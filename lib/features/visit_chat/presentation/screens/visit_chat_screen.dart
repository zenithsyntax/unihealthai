import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../patients/domain/entities/patient_entity.dart';
import '../../application/visit_chat_notifier.dart';

class VisitChatScreen extends ConsumerStatefulWidget {
  final String patientId;
  final VisitEntity visit;

  const VisitChatScreen({
    super.key,
    required this.patientId,
    required this.visit,
  });

  @override
  ConsumerState<VisitChatScreen> createState() => _VisitChatScreenState();
}

class _VisitChatScreenState extends ConsumerState<VisitChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        visitChatParamsProvider.overrideWithValue((
          patientId: widget.patientId,
          visitId: widget.visit.id,
          visit: widget.visit,
        )),
        visitChatNotifierProvider.overrideWith(() => VisitChatNotifier()),
      ],
      child: const _VisitChatContent(),
    );
  }
}

class _VisitChatContent extends ConsumerStatefulWidget {
  const _VisitChatContent();

  @override
  ConsumerState<_VisitChatContent> createState() => _VisitChatContentState();
}

class _VisitChatContentState extends ConsumerState<_VisitChatContent> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final params = ref.watch(visitChatParamsProvider);
    final chatState = ref.watch(visitChatNotifierProvider);

    // Auto scroll to bottom when messages change
    ref.listen(visitChatNotifierProvider, (previous, next) {
      if (next.messages.length > (previous?.messages.length ?? 0)) {
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Visit Assistant', style: TextStyle(fontSize: 16)),
            Text(params.visit?.date.toString().split(' ')[0] ?? '',
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: chatState.messages.isEmpty
                ? const Center(child: Text('Initializing chat context...'))
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: chatState.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatState.messages[index];
                      return Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(12),
                                topRight: const Radius.circular(12),
                                bottomLeft: message.isUser
                                    ? const Radius.circular(12)
                                    : Radius.zero,
                                bottomRight: message.isUser
                                    ? Radius.zero
                                    : const Radius.circular(12)),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isUser
                                  ? Colors.white
                                  : Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (chatState.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("AI is thinking...",
                      style: TextStyle(color: Colors.grey, fontSize: 12))),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 5)
            ]),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask about this visit...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(ref),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () => _sendMessage(ref),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(WidgetRef ref) {
    if (_controller.text.trim().isEmpty) return;

    ref
        .read(visitChatNotifierProvider.notifier)
        .sendMessage(_controller.text.trim());

    _controller.clear();
  }
}

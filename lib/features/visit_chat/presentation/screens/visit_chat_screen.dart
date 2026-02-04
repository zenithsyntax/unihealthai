import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
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
      backgroundColor: const Color(0xFFF5F7FA), // Light grey background
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visit Assistant',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              params.visit != null
                  ? 'Visit on ${params.visit!.date.toString().split(" ")[0]}'
                  : 'Chat',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFE2E8F0),
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatState.messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.medical_services_outlined,
                            size: 48,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'How can I help you regarding this visit?',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    itemCount: chatState.messages.length +
                        (chatState.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= chatState.messages.length) {
                        return const _TypingIndicator();
                      }

                      final message = chatState.messages[index];
                      final isLastMessage =
                          index == chatState.messages.length - 1;

                      return _ChatMessageItem(
                        message: message.text,
                        isUser: message.isUser,
                        isLast: isLastMessage,
                      );
                    },
                  ),
          ),
          _buildInputArea(context, ref, chatState.isLoading),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, WidgetRef ref, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: 5,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: const Color(0xFF1E293B),
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ask a question...',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(ref),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: isLoading
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF3B82F6),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send_rounded, size: 20),
                color: Colors.white,
                onPressed: isLoading ? null : () => _sendMessage(ref),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(WidgetRef ref) {
    if (_controller.text.trim().isEmpty) return;

    ref
        .read(visitChatNotifierProvider.notifier)
        .sendMessage(_controller.text.trim());

    _controller.clear();
    // Keep focus so user can type next message easily
    _focusNode.requestFocus();
  }
}

class _ChatMessageItem extends StatelessWidget {
  final String message;
  final bool isUser;
  final bool isLast;

  const _ChatMessageItem({
    required this.message,
    required this.isUser,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child:
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF3B82F6) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(20),
                ),
                boxShadow: isUser
                    ? [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        )
                      ],
              ),
              child: isUser
                  ? Text(
                      message,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    )
                  : MarkdownBody(
                      data: message,
                      selectable: true,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.inter(
                          fontSize: 15,
                          height: 1.5,
                          color: const Color(0xFF334155),
                        ),
                        h1: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                        h2: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                        h3: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                        listBullet: const TextStyle(
                          color: Color(0xFF64748B),
                        ),
                        strong: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        code: GoogleFonts.firaCode(
                          backgroundColor: const Color(0xFFF1F5F9),
                          color: const Color(0xFF0F172A),
                          fontSize: 13,
                        ),
                        blockquote: const TextStyle(
                          color: Color(0xFF64748B),
                          fontStyle: FontStyle.italic,
                        ),
                        blockquoteDecoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: const Color(0xFFCBD5E1),
                              width: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 12),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child:
                  const Icon(Icons.person, color: Color(0xFF64748B), size: 18),
            ),
          ],
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:
                const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.zero,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final double value =
                        (_controller.value + index * 0.33) % 1.0;
                    final double opacity =
                        0.4 + 0.6 * (1.0 - (0.5 - value).abs() * 2);

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF64748B).withValues(alpha: opacity),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../patients/domain/entities/patient_entity.dart';
import '../../application/visit_chat_notifier.dart';
import '../../domain/entities/chat_message.dart';

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

  // File Attachment State
  final List<({Uint8List bytes, String name, String mimeType})> _selectedFiles =
      [];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true, // Important to get bytes
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          for (final file in result.files) {
            String mimeType = 'application/octet-stream';
            if (file.extension == 'pdf') {
              mimeType = 'application/pdf';
            } else if (['jpg', 'jpeg']
                .contains(file.extension?.toLowerCase())) {
              mimeType = 'image/jpeg';
            } else if (file.extension?.toLowerCase() == 'png') {
              mimeType = 'image/png';
            }

            if (file.bytes != null) {
              _selectedFiles.add((
                bytes: file.bytes!,
                name: file.name,
                mimeType: mimeType,
              ));
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking file: $e')),
        );
      }
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  void _clearFiles() {
    setState(() {
      _selectedFiles.clear();
    });
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
                        attachments: message.attachments,
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
        child: Column(
          children: [
            // Selected Files Preview
            if (_selectedFiles.isNotEmpty)
              Container(
                constraints: const BoxConstraints(maxHeight: 120),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _selectedFiles.length,
                  itemBuilder: (context, index) {
                    final file = _selectedFiles[index];
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFBFDBFE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                file.mimeType == 'application/pdf'
                                    ? Icons.picture_as_pdf
                                    : Icons.image,
                                size: 20,
                                color: const Color(0xFF3B82F6),
                              ),
                              InkWell(
                                onTap: () => _removeFile(index),
                                child: const Icon(Icons.close,
                                    size: 16, color: Color(0xFF60A5FA)),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            file.name,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: const Color(0xFF1E40AF),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            // Input Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: isLoading ? null : _pickFile,
                  icon: const Icon(Icons.attach_file_rounded),
                  color: const Color(0xFF64748B),
                  tooltip: 'Attach file',
                ),
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
                      enabled: !isLoading,
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
          ],
        ),
      ),
    );
  }

  void _sendMessage(WidgetRef ref) {
    if (_controller.text.trim().isEmpty && _selectedFiles.isEmpty) return;

    ref.read(visitChatNotifierProvider.notifier).sendMessage(
          _controller.text.trim().isEmpty
              ? (_selectedFiles.length == 1
                  ? "Analyzed attached file."
                  : "Analyzed attached files.")
              : _controller.text.trim(),
          attachments: List.from(_selectedFiles),
        );

    _controller.clear();
    _clearFiles();
    // Keep focus so user can type next message easily
    _focusNode.requestFocus();
  }
}

class _ChatMessageItem extends StatelessWidget {
  final String message;
  final bool isUser;
  final bool isLast;
  final List<ChatAttachment> attachments;

  const _ChatMessageItem({
    required this.message,
    required this.isUser,
    required this.isLast,
    this.attachments = const [],
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
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (attachments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _AttachmentList(
                      attachments: attachments,
                      isUser: isUser,
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF3B82F6) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft:
                          isUser ? const Radius.circular(20) : Radius.zero,
                      bottomRight:
                          isUser ? Radius.zero : const Radius.circular(20),
                    ),
                    boxShadow: isUser
                        ? [
                            BoxShadow(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.2),
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
              ],
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

class _AttachmentList extends StatelessWidget {
  final List<ChatAttachment> attachments;
  final bool isUser;

  const _AttachmentList({required this.attachments, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: isUser ? WrapAlignment.end : WrapAlignment.start,
      children: attachments.map((attachment) {
        final isPdf = attachment.mimeType == 'application/pdf' ||
            (attachment.name?.toLowerCase().endsWith('.pdf') ?? false);
        final isImage = attachment.mimeType?.startsWith('image/') == true ||
            (attachment.name?.toLowerCase().endsWith('.jpg') ?? false) ||
            (attachment.name?.toLowerCase().endsWith('.png') ?? false) ||
            (attachment.name?.toLowerCase().endsWith('.jpeg') ?? false);

        // If we have a URL and it's an image, try to show the image
        if (attachment.url != null && isImage) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
              child: Image.network(
                attachment.url!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFileCard(attachment, isPdf),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 200,
                    height: 150,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return _buildFileCard(attachment, isPdf);
      }).toList(),
    );
  }

  Widget _buildFileCard(ChatAttachment attachment, bool isPdf) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUser ? const Color(0xFFEFF6FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUser ? const Color(0xFFBFDBFE) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isUser ? Colors.white : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isPdf ? Icons.picture_as_pdf : Icons.image,
                  size: 20,
                  color: const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  attachment.name ?? 'Unknown File',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
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

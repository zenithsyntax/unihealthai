import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../patients/domain/entities/patient_entity.dart';
import '../../application/chat_notifier.dart';
import '../../../visit_chat/domain/entities/chat_message.dart';

class AIChatWidget extends ConsumerStatefulWidget {
  final PatientEntity patient;

  const AIChatWidget({super.key, required this.patient});

  @override
  ConsumerState<AIChatWidget> createState() => _AIChatWidgetState();
}

class _AIChatWidgetState extends ConsumerState<AIChatWidget> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        chatParamsProvider.overrideWithValue((
          patientId: widget.patient.id,
          patient: widget.patient,
        )),
        chatNotifierProvider.overrideWith(() => ChatNotifier()),
      ],
      child: const _AIChatContent(),
    );
  }
}

class _AIChatContent extends ConsumerStatefulWidget {
  const _AIChatContent();

  @override
  ConsumerState<_AIChatContent> createState() => _AIChatContentState();
}

class _AIChatContentState extends ConsumerState<_AIChatContent> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // File Attachment State
  final List<({Uint8List bytes, String name, String mimeType})> _selectedFiles =
      [];

  // Mention State
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<String> _filteredMentions = [];
  String? _currentMentionFilter;
  int _mentionStartIndex = -1;

  Map<String, String> _getMentionOptions(PatientEntity p) {
    return {
      // 🧍 Personal / Demographics
      'first_name': p.firstName,
      'last_name': p.lastName,
      'full_name': p.name,
      'gender': p.gender,
      'dob': p.dateOfBirth.toString().split(' ')[0],
      'age': '${p.age} years',
      'nationality': p.nationality,
      'marital_status': p.maritalStatus,
      'occupation': p.occupation,
      // 📞 Contact / Emergency
      'contact_number': p.contactNumber,
      'emergency_contact_name': p.emergencyContactName,
      'emergency_contact_phone': p.emergencyContactPhone,
      'emergency_relationship': p.emergencyContactRelationship,
      // 🏥 Medical History
      'blood_type': p.bloodType,
      'heart_condition': p.hasHeartCondition ? 'Yes' : 'No',
      'diabetes': p.hasDiabetes ? 'Yes' : 'No',
      'asthma': p.hasAsthma ? 'Yes' : 'No',
      'high_blood_pressure': p.hasHighBloodPressure ? 'Yes' : 'No',
      'surgical_history': p.hasSurgicalHistory ? 'Yes' : 'No',
      'surgery_details': p.surgeryDetails ?? 'None',
      'family_history': p.familyMedicalHistory ?? 'None',
      // 💊 Medications & Allergies
      'taking_medication': p.isTakingMedication ? 'Yes' : 'No',
      'current_medications': p.currentMedications ?? 'None',
      'drug_allergies': p.drugAllergyDetails ?? 'None',
      'food_allergies': p.foodAllergyDetails ?? 'None',
      // 🧠 Mental & Lifestyle
      'mental_health_notes': p.mentalHealthNotes ?? 'None',
      'smoking_status': p.smokingStatus,
      'alcohol_consumption': p.alcoholConsumption,
      'activity_level': p.physicalActivityLevel,
      'sleep_hours': '${p.sleepHoursPerNight ?? 'Unknown'} hours',
      // 📏 Body Metrics / Vitals
      'height': '${p.height} cm',
      'weight': '${p.weight} kg',
      'bmi': p.bmi?.toStringAsFixed(1) ?? 'N/A',
      'resting_heart_rate': '${p.restingHeartRate ?? 'N/A'} bpm',
      'blood_pressure': p.bloodPressure ?? 'N/A',
      // 📄 Administrative / Consent
      'insurance_provider': p.insuranceProvider ?? 'None',
      'policy_number': p.insurancePolicyNumber ?? 'None',
      'consent_given': p.consentToTreatment ? 'Yes' : 'No',
      'consent_date': p.consentDate?.toString().split(' ')[0] ?? 'N/A',
      'notes': p.notes ?? 'None',
    };
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text;
    final selection = _controller.selection;

    if (!selection.isValid || selection.baseOffset < 0) {
      _removeOverlay();
      return;
    }

    // Find if we are typing a mention
    final cursorPos = selection.baseOffset;
    final textBeforeCursor = text.substring(0, cursorPos);
    final lastAtPos = textBeforeCursor.lastIndexOf('@');

    if (lastAtPos != -1) {
      // Check if there is a space before @ or it's the start of text
      bool isValidStart = lastAtPos == 0 || text[lastAtPos - 1] == ' ';

      if (isValidStart) {
        final filter = text.substring(lastAtPos + 1, cursorPos);
        // Ensure no spaces in the filter for now (simple mentions)
        if (!filter.contains(' ')) {
          _currentMentionFilter = filter;
          _mentionStartIndex = lastAtPos;
          _showMentionsOverlay();
          return;
        }
      }
    }

    _removeOverlay();
  }

  void _showMentionsOverlay() {
    final params = ref.read(chatParamsProvider);
    final patient = params.patient;

    final options = _getMentionOptions(patient);
    setState(() {
      _filteredMentions = options.keys
          .where(
            (key) => key.toLowerCase().contains(
                  _currentMentionFilter!.toLowerCase(),
                ),
          )
          .toList();
    });

    if (_filteredMentions.isEmpty) {
      _removeOverlay();
      return;
    }

    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _currentMentionFilter = null;
    _mentionStartIndex = -1;
  }

  void _insertMention(String key) {
    if (_mentionStartIndex == -1 || _currentMentionFilter == null) return;

    final params = ref.read(chatParamsProvider);
    final patient = params.patient;

    final options = _getMentionOptions(patient);
    final value = options[key] ?? '';
    final text = _controller.text;
    final afterCursor = text.substring(_controller.selection.baseOffset);

    // Replace @filter with value
    final newText =
        '${text.substring(0, _mentionStartIndex)}$value $afterCursor';

    _controller.text = newText;
    _controller.selection = TextSelection.collapsed(
      offset: _mentionStartIndex + value.length + 1,
    );

    _removeOverlay();
    _focusNode.requestFocus();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 250,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, -200), // Show above
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredMentions.length,
                itemBuilder: (context, index) {
                  final key = _filteredMentions[index];
                  final params = ref.read(chatParamsProvider);
                  final patient = params.patient;
                  final options = _getMentionOptions(patient);
                  final value = options[key] ?? '';

                  return ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.person_outline,
                      size: 18,
                      color: Color(0xFF3B82F6),
                    ),
                    title: Text(
                      key,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => _insertMention(key),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
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
            } else if ([
              'jpg',
              'jpeg',
            ].contains(file.extension?.toLowerCase())) {
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
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
    final chatState = ref.watch(chatNotifierProvider);

    // Auto scroll to bottom when messages change
    ref.listen(chatNotifierProvider, (previous, next) {
      if (next.messages.length > (previous?.messages.length ?? 0)) {
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        // Handle unbounded height constraints (e.g., inside unconstrained Column/Row)
        final height = constraints.maxHeight.isInfinite
            ? MediaQuery.of(context).size.height
            : constraints.maxHeight;

        return SizedBox(
          height: height,
          child: Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                AppBar(
                  title: const Text(
                    'AI Assistant',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.white,
                ),
                Expanded(
                  child: chatState.messages.isEmpty && !chatState.isLoading
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
                                      color:
                                          Colors.black.withValues(alpha: 0.05),
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
                                'Ask me anything about the patient...',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        )
                      : chatState.isLoading && chatState.messages.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : SelectionArea(
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.all(16),
                                itemCount: chatState.messages.length +
                                    (chatState.isLoading ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == chatState.messages.length) {
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
                ),
                _buildInputArea(context, ref, chatState.isLoading),
              ],
            ),
          ),
        );
      },
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selected Files Preview
            if (_selectedFiles.isNotEmpty)
              Container(
                constraints: const BoxConstraints(maxHeight: 120),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Color(0xFF60A5FA),
                                ),
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
                  child: CompositedTransformTarget(
                    link: _layerLink,
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

    ref.read(chatNotifierProvider.notifier).sendMessage(
          _controller.text.trim().isEmpty
              ? (_selectedFiles.length == 1
                  ? "Analyzed attached file."
                  : "Analyzed attached files.")
              : _controller.text.trim(),
          attachments: List.from(_selectedFiles),
        );

    _controller.clear();
    _clearFiles();
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
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 18,
              ),
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
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
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
                                  color: const Color(
                                    0xFF3B82F6,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isUser
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
                                  styleSheet: MarkdownStyleSheet(
                                    p: GoogleFonts.inter(
                                      color: const Color(0xFF334155),
                                      fontSize: 15,
                                      height: 1.6,
                                    ),
                                    strong: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isLast) ...[
                  const SizedBox(height: 8),
                  Text(
                    isUser ? 'You' : 'AI Assistant',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
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

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isUser
                ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUser
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                  : Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPdf ? Icons.picture_as_pdf : Icons.image,
                size: 16,
                color: const Color(0xFF3B82F6),
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Text(
                  attachment.name ?? 'Unnamed File',
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
        );
      }).toList(),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
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
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
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
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(150),
                const SizedBox(width: 4),
                _buildDot(300),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: const Color(
              0xFF3B82F6,
            ).withValues(alpha: 0.5 + (value * 0.5)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

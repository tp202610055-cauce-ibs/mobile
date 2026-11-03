import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/nutritionist_assignment_notifier.dart';

/// Abre la hoja del código y avisa si la vinculación prosperó.
Future<void> showInvitationCodeSheet(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final name = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _InvitationCodeSheet(),
  );
  if (name != null && context.mounted) {
    CauceToast.success(context, title: l10n.profileInvitationCodeLinked(name));
  }
}

/// Campo del código de invitación (HU0020), con su envío y su error.
class _InvitationCodeSheet extends ConsumerStatefulWidget {
  const _InvitationCodeSheet();

  @override
  ConsumerState<_InvitationCodeSheet> createState() =>
      _InvitationCodeSheetState();
}

class _InvitationCodeSheetState extends ConsumerState<_InvitationCodeSheet> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final notifier = ref.read(nutritionistAssignmentNotifierProvider.notifier);
    final linked = await notifier.redeem(_code.text);
    if (!linked || !mounted) {
      return;
    }
    final assignment = ref.read(nutritionistAssignmentNotifierProvider);
    Navigator.of(context).pop(assignment.assignment?.nutritionistFullName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(nutritionistAssignmentNotifierProvider);
    final error = state.error;

    return Padding(
      padding: EdgeInsets.only(
        left: CauceSpacing.space4,
        right: CauceSpacing.space4,
        top: CauceSpacing.space6,
        bottom: MediaQuery.viewInsetsOf(context).bottom + CauceSpacing.space6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.profileInvitationCodeTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(l10n.profileInvitationCodeBody),
          const SizedBox(height: CauceSpacing.space4),
          if (error != null) ...<Widget>[
            CauceErrorBanner(error: error),
            const SizedBox(height: CauceSpacing.space4),
          ],
          CauceTextField(
            key: const Key('profile_invitation_code_field'),
            controller: _code,
            label: l10n.registerInvitationCodeLabel,
            textCapitalization: TextCapitalization.characters,
            enabled: !state.submitting,
            onChanged: (_) => ref
                .read(nutritionistAssignmentNotifierProvider.notifier)
                .clearError(),
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceButton(
            key: const Key('profile_invitation_code_submit'),
            label: l10n.profileInvitationCodeSubmit,
            loading: state.submitting,
            onPressed: state.submitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}

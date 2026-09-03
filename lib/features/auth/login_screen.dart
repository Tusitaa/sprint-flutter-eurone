import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/mock_data.dart';
import '../../core/models/user_role.dart';
import '../../shared/widgets/euri_mascot.dart';
import '../../shared/widgets/section_panel.dart';
import 'auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitCredentials() async {
    FocusScope.of(context).unfocus();
    final user = await ref
        .read(authControllerProvider.notifier)
        .signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
    if (!mounted) {
      return;
    }
    final role = user?.role;
    if (role != null) {
      context.go(role.homePath);
    }
  }

  Future<void> _loginWithCredential(MockCredential credential) async {
    _emailController.text = credential.email;
    _passwordController.text = credential.password;
    ref.read(authControllerProvider.notifier).clearError();
    await _submitCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final auth = ref.watch(authControllerProvider);
    final errorMessage = auth.errorMessage;
    final isLoading = auth.isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 900;
                  final formColumn = Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _BrandPanel(theme: theme, colorScheme: colorScheme),
                      const SizedBox(height: 14),
                      _buildFormPanel(errorMessage, isLoading),
                    ],
                  );
                  final credentialsPanel = _CredentialsPanel(
                    isLoading: isLoading,
                    onSelect: _loginWithCredential,
                  );

                  return compact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            formColumn,
                            const SizedBox(height: 14),
                            credentialsPanel,
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: formColumn),
                            const SizedBox(width: 14),
                            Expanded(child: credentialsPanel),
                          ],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormPanel(String? errorMessage, bool isLoading) {
    return SectionPanel(
      title: 'Entrar na plataforma',
      subtitle: 'Acesse com e-mail e senha para abrir a área da sua persona.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (_) =>
                ref.read(authControllerProvider.notifier).clearError(),
            decoration: const InputDecoration(
              labelText: 'E-mail',
              hintText: 'nome@euroone.dev',
              prefixIcon: Icon(Icons.alternate_email),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onChanged: (_) =>
                ref.read(authControllerProvider.notifier).clearError(),
            onFieldSubmitted: (_) {
              if (!isLoading) {
                _submitCredentials();
              }
            },
            decoration: const InputDecoration(
              labelText: 'Senha',
              hintText: '******',
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 10),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: isLoading ? null : _submitCredentials,
            icon: isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.login),
            label: Text(isLoading ? 'Entrando...' : 'Entrar'),
          ),
          const SizedBox(height: 10),
          Text(
            'Ambiente de demonstração com dados simulados. '
            'Use uma das credenciais ao lado para explorar cada persona.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel({required this.theme, required this.colorScheme});

  final ThemeData theme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const EuriMascot(size: 48),
                const SizedBox(width: 12),
                Text(
                  'EuroONE',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'O aluno por inteiro, em uma só tela.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Plataforma de aprendizagem em saúde que reúne presença, entregas, '
              'evolução, alertas e recompensas para decisões pedagógicas mais claras.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _PillLabel('Educando'),
                _PillLabel('Educador'),
                _PillLabel('Gestão'),
                _PillLabel('Dados simulados'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CredentialsPanel extends StatelessWidget {
  const _CredentialsPanel({required this.isLoading, required this.onSelect});

  final bool isLoading;
  final ValueChanged<MockCredential> onSelect;

  @override
  Widget build(BuildContext context) {
    return SectionPanel(
      title: 'Credenciais de acesso',
      subtitle: 'Toque em "Entrar" para acessar a persona desejada.',
      child: Column(
        children: [
          for (final credential in mockCredentials) ...[
            _CredentialCard(
              credential: credential,
              isLoading: isLoading,
              onSelect: onSelect,
            ),
            if (credential != mockCredentials.last)
              const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _CredentialCard extends StatelessWidget {
  const _CredentialCard({
    required this.credential,
    required this.isLoading,
    required this.onSelect,
  });

  final MockCredential credential;
  final bool isLoading;
  final ValueChanged<MockCredential> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_iconFor(credential.role), color: colorScheme.secondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(credential.role.label, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    credential.email,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    'Senha: ${credential.password}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton.icon(
              onPressed: isLoading ? null : () => onSelect(credential),
              icon: const Icon(Icons.login, size: 18),
              label: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(UserRole role) {
    return switch (role) {
      UserRole.educando => Icons.school_outlined,
      UserRole.educador => Icons.dashboard_outlined,
      UserRole.gestao => Icons.query_stats_outlined,
    };
  }
}

class _PillLabel extends StatelessWidget {
  const _PillLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}

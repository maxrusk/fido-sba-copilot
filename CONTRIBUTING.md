# 🤝 Contributing to Fido SBA Copilot

Thank you for your interest in contributing to Fido SBA Copilot! This document provides guidelines and information for contributors.

## 🚀 Quick Start

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/yourusername/fido-sba-copilot.git
   cd fido-sba-copilot
   ```
3. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Make your changes**
5. **Test your changes**
6. **Commit and push**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   git push origin feature/your-feature-name
   ```
7. **Create a Pull Request**

## 📋 Development Setup

### Prerequisites
- Node.js 18+
- MongoDB Atlas account
- OpenAI API key

### Local Development
1. **Install dependencies**
   ```bash
   cd backend
   npm install
   ```

2. **Set up environment variables**
   ```bash
   # Create .env file in backend/
   cp .env.example .env
   # Edit .env with your actual values
   ```

3. **Start development server**
   ```bash
   cd backend
   node index.js
   ```

4. **Open frontend**
   ```bash
   open frontend/index.html
   ```

## 🎯 Areas for Contribution

### High Priority
- **Bug fixes** - Any issues you encounter
- **Documentation** - Improving README, API docs, etc.
- **Testing** - Adding unit tests, integration tests
- **Security** - Security improvements and vulnerability fixes

### Medium Priority
- **UI/UX improvements** - Better user experience
- **Performance** - Optimizing response times
- **Accessibility** - Making the app more accessible
- **Internationalization** - Adding more languages

### Low Priority
- **New features** - Additional SBA loan programs
- **Analytics** - User behavior tracking
- **Advanced exports** - More export formats

## 📝 Coding Standards

### JavaScript/Node.js
- Use **ES6+** features
- Follow **Airbnb JavaScript Style Guide**
- Use **async/await** instead of callbacks
- Add **JSDoc comments** for functions
- Use **meaningful variable names**

### CSS
- Use **BEM methodology** for class names
- Keep styles **modular and reusable**
- Use **CSS custom properties** for theming
- Ensure **responsive design**

### Git Commit Messages
Use **Conventional Commits** format:
```
type(scope): description

feat(auth): add password reset functionality
fix(chat): resolve message display issue
docs(readme): update installation instructions
style(ui): improve button hover effects
refactor(api): simplify authentication middleware
test(backend): add user model tests
```

### Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

## 🧪 Testing

### Running Tests
```bash
cd backend
npm test
```

### Writing Tests
- Use **Jest** for testing
- Test both **success and error cases**
- Mock external dependencies
- Aim for **80%+ code coverage**

### Test Structure
```javascript
describe('User Authentication', () => {
  describe('POST /auth/signup', () => {
    it('should create a new user with valid data', async () => {
      // Test implementation
    });
    
    it('should reject duplicate email', async () => {
      // Test implementation
    });
  });
});
```

## 🔍 Code Review Process

### Before Submitting
- [ ] Code follows style guidelines
- [ ] Tests pass locally
- [ ] No console.log statements
- [ ] Environment variables are not hardcoded
- [ ] Documentation is updated

### Pull Request Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Security fix

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots for UI changes

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented my code where necessary
- [ ] I have made corresponding changes to documentation
```

## 🐛 Reporting Issues

### Bug Report Template
```markdown
## Bug Description
Clear description of the bug

## Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g. macOS, Windows]
- Browser: [e.g. Chrome, Safari]
- Node.js version: [e.g. 18.0.0]

## Additional Context
Any other context about the problem
```

## 💡 Feature Requests

### Feature Request Template
```markdown
## Feature Description
Clear description of the feature

## Problem Statement
What problem does this solve?

## Proposed Solution
How should this work?

## Alternatives Considered
Other approaches you considered

## Additional Context
Any other context or screenshots
```

## 🏷️ Labels

We use the following labels for issues and PRs:
- `bug` - Something isn't working
- `enhancement` - New feature or request
- `documentation` - Improvements to documentation
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention is needed
- `priority: high` - High priority items
- `priority: low` - Low priority items

## 📞 Getting Help

- **GitHub Issues** - For bugs and feature requests
- **GitHub Discussions** - For questions and general discussion
- **Email** - For security issues (don't post publicly)

## 🎉 Recognition

Contributors will be recognized in:
- **README.md** contributors section
- **GitHub contributors** page
- **Release notes** for significant contributions

## 📄 License

By contributing to Fido SBA Copilot, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to Fido SBA Copilot! 🐕✨** 
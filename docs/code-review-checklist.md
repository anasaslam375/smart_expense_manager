# Code Review Checklist

## Functionality

- [ ] Code implements the intended functionality
- [ ] Edge cases are handled appropriately
- [ ] Error handling is comprehensive
- [ ] User feedback is provided for errors
- [ ] Validation is implemented where needed
- [ ] Business logic is correct
- [ ] Integration points work correctly

## Code Quality

- [ ] Code follows project style guide
- [ ] Code is readable and self-documenting
- [ ] Functions are small and focused
- [ ] No code duplication
- [ ] Meaningful variable and function names
- [ ] No magic numbers or hardcoded values
- [ ] Comments explain "why", not "what"
- [ ] Complex logic is documented
- [ ] Duplicated UI patterns extracted into reusable components
- [ ] Common operations use extension methods where appropriate
- [ ] Business logic centralized in utilities

## Architecture

- [ ] Follows Clean Architecture principles
- [ ] Separation of concerns maintained
- [ ] Dependencies are appropriate
- [ ] SOLID principles followed
- [ ] Design patterns used correctly
- [ ] No circular dependencies
- [ ] Layer boundaries respected

## Testing

- [ ] Unit tests included for business logic
- [ ] Tests cover happy path
- [ ] Tests cover error cases
- [ ] Tests cover edge cases
- [ ] Tests are meaningful and maintainable
- [ ] Mocking used appropriately
- [ ] Test coverage meets requirements

## Performance

- [ ] Performance considerations addressed
- [ ] No unnecessary allocations
- [ ] Efficient algorithms used
- [ ] Database queries optimized
- [ ] Network calls minimized
- [ ] Image loading optimized
- [ ] Memory usage appropriate

## Security

- [ ] No sensitive data in logs
- [ ] No hardcoded secrets or API keys
- [ ] Input validation implemented
- [ ] Output encoding where needed
- [ ] Authentication/authorization checked
- [ ] Data encrypted at rest
- [ ] TLS used for network calls
- [ ] Dependencies are secure

## iOS Specific

- [ ] SwiftUI best practices followed
- [ ] @State, @Published used correctly
- [ ] Memory management (weak/unowned references)
- [ ] Main thread usage correct
- [ ] Background tasks appropriate
- [ ] SwiftData/Core Data used correctly
- [ ] Async/await used appropriately
- [ ] No force unwrapping (!)

## Android Specific

- [ ] Kotlin best practices followed
- [ ] Coroutines used correctly
- [ ] Flow/StateFlow used appropriately
- [ ] Room database used correctly
- [ ] Hilt dependency injection correct
- [ ] Lifecycle awareness implemented
- [ ] Memory leaks avoided
- [ ] Background tasks appropriate

## Accessibility

- [ ] All interactive elements have labels
- [ ] Color contrast meets WCAG AA
- [ ] Touch targets minimum 44x44 points
- [ ] Dynamic type supported
- [ ] Screen reader compatible
- [ ] Keyboard navigation supported
- [ ] Focus management implemented

## Documentation

- [ ] README updated if needed
- [ ] API documentation updated
- [ ] Architecture docs updated
- [ ] Changelog updated
- [ ] Inline comments for complex logic
- [ ] Public APIs documented

## Git Standards

- [ ] Commit message follows conventions
- [ ] Branch name follows conventions
- [ ] No merge conflicts
- [ ] PR description is clear
- [ ] Related issue referenced
- [ ] Screenshots included for UI changes

## Build and CI/CD

- [ ] Code compiles without errors
- [ ] No linting errors
- [ ] All tests pass
- [ ] Build succeeds on CI
- [ ] No new warnings introduced
- [ ] Dependencies updated if needed

## Review Process

- [ ] Reviewer understands the changes
- [ ] Questions asked for unclear code
- [ ] Suggestions are constructive
- [ ] Approval only when satisfied
- [ ] Author responds to all comments
- [ ] Changes verified after updates

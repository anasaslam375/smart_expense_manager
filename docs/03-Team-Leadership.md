# Part 3: Team Leadership

## Sprint Planning

### Preparation

- Review backlog items with Product Owner
- Ensure user stories have acceptance criteria
- Estimate complexity with team (story points or hours)
- Identify dependencies between items
- Check team capacity and availability

### Planning Meeting (1 hour)

1. Review previous sprint outcomes
2. Select sprint goal
3. Select backlog items for sprint
4. Break down items into tasks
5. Assign tasks to team members
6. Identify risks and blockers
7. Confirm capacity and commitments

### Best Practices

- Focus on sprint goal, not just individual items
- Keep items small enough to complete in 2-3 days
- Use historical velocity for planning
- Leave buffer for unexpected work
- Get commitment from team, not just assignment

---

## Daily Stand-ups

### Format (15 minutes max)

- Same time daily, preferably morning
- Each member answers 3 questions:
  1. What did I complete yesterday?
  2. What will I work on today?
  3. Are there any blockers or impediments?

### Guidelines

- Stand up to keep meeting short
- Focus on blockers, not detailed status
- Take discussions offline
- Identify dependencies between team members
- Update task board after stand-up

### Remote Team Considerations

- Use video for better connection
- Have a dedicated channel for blockers
- Time zone awareness for distributed teams
- Use async updates when needed

---

## Sprint Retrospectives

### Structure (1 hour)

1. Set the stage (5 min)
   - Create safe environment
   - Review retrospective goal

2. Gather data (10 min)
   - Review metrics (velocity, bugs, etc.)
   - Timeline of sprint events
   - What went well, what didn't

3. Generate insights (15 min)
   - Identify patterns
   - Root cause analysis
   - Discuss themes

4. Decide what to do (20 min)
   - Select 1-2 action items
   - Assign owners
   - Set timeline

5. Close retrospective (10 min)
   - Summary of action items
   - Appreciation and recognition

### Techniques

- Start/Stop/Continue
- Mad/Sad/Glad
- 4Ls (Liked, Learned, Lacked, Longed for)
- Sailboat (Wind helping, anchors holding back)

### Follow-up

- Track action items
- Review in next retrospective
- Celebrate improvements

---

## Code Reviews

### Review Process

1. Developer creates pull request
2. Automated checks run (lint, tests)
3. Reviewer assigned (at least 1 approval required)
4. Reviewer provides feedback within 24 hours
5. Developer addresses feedback
6. Reviewer approves when satisfied
7. Code merged after approval

### Review Checklist

**General**:

- Code follows style guide
- Tests included and passing
- No hardcoded values
- Error handling implemented
- Performance considered
- Security reviewed
- Accessibility checked
- Documentation updated
- No merge conflicts

**Android Specific**:

- Kotlin best practices followed
- Jetpack Compose components used correctly
- Hilt dependency injection proper
- Room database queries optimized
- Coroutines used correctly
- StateFlow/SharedFlow appropriate
- Memory leaks avoided (proper lifecycle)

**iOS Specific**:

- Swift best practices followed
- SwiftUI components used correctly
- SwiftData/Core Data operations correct
- Async/await used properly
- Combine publishers appropriate
- Memory management correct (weak/unowned)
- Auto Layout constraints valid

**Flutter Specific**:

- Dart best practices followed
- BLoC pattern used correctly
- State management appropriate
- Hive database used correctly
- GetIt dependency injection correct
- Lifecycle awareness implemented
- Memory leaks avoided (dispose controllers)
- const widgets used where possible

### Code Review Best Practices

- Keep PRs small (< 400 lines)
- Review in timely manner
- Provide constructive feedback
- Explain why, not just what
- Pair program for complex changes
- Use inline comments for specific issues

### Review Etiquette

- Be respectful and constructive
- Focus on code, not person
- Ask questions, don't dictate
- Acknowledge good work
- Resolve disagreements offline

---

## Mentoring Junior Developers

### Onboarding

**Android Developer Onboarding**:

- Set up Android Studio with Kotlin plugin
- Configure Gradle and dependencies
- Review Jetpack Compose basics
- Understand Hilt DI setup
- Learn Room database schema
- Review Retrofit networking
- Set up emulator and physical device testing

**iOS Developer Onboarding**:

- Set up Xcode with Apple Developer account
- Configure provisioning profiles and signing
- Review SwiftUI basics
- Understand SwiftData/Core Data
- Learn URLSession async/await
- Review Combine framework
- Set up iOS Simulator and physical device testing

**Flutter Developer Onboarding**:

- Set up Flutter SDK and Android Studio/VS Code
- Configure pubspec.yaml dependencies
- Review Flutter widget basics
- Understand BLoC pattern
- Learn Hive database
- Review Dio networking
- Set up emulator and physical device testing

**Common Onboarding**:

- Provide clear documentation
- Assign buddy/mentor
- Review architecture and codebase
- Explain team processes
- Introduce to team members

### Skill Development

- Pair programming sessions
- Code review with explanation
- Assign progressively complex tasks
- Encourage questions and learning
- Provide resources and references
- Set learning goals

### Regular Check-ins

- Weekly 1:1 meetings
- Discuss progress and challenges
- Provide feedback and guidance
- Identify training needs
- Career development discussions

### Growth Opportunities

- Lead small features
- Present in team meetings
- Contribute to architecture discussions
- Attend conferences/workshops
- Shadow senior developers

---

## Resolving Technical Disagreements

### Process

1. Listen to all perspectives
2. Focus on facts and data
3. Consider trade-offs objectively
4. Prototype or proof of concept if needed
5. Make decision with clear rationale
6. Document decision (ADR)
7. Move forward as team

### Decision Framework

- Impact on user experience
- Technical complexity
- Maintenance cost
- Time to implement
- Team expertise
- Long-term viability

### Escalation

- Team lead makes final decision if needed
- Refer to architecture principles
- Consider business priorities
- Document and revisit later if needed

---

## Improving Team Performance

### Metrics to Track

- Sprint velocity
- Cycle time
- Code quality (bugs, test coverage)
- Deployment frequency
- Lead time
- Team satisfaction

### Improvement Strategies

- Regular retrospectives
- Training and skill development
- Process optimization
- Tool improvements
- Knowledge sharing sessions
- Cross-team collaboration

### Recognition

- Celebrate wins and achievements
- Acknowledge individual contributions
- Share success stories
- Provide growth opportunities
- Positive feedback culture

---

## Managing Technical Debt

### Identification

- Track during code reviews
- Tag in issue tracker
- Assess impact and priority
- Estimate effort to fix

### Prioritization

- High impact, low effort: Fix immediately
- High impact, high effort: Plan for next sprint
- Low impact, low effort: Fix when convenient
- Low impact, high effort: Defer or ignore

### Management

- Allocate 20% of sprint to debt reduction
- Include in sprint planning
- Track debt metrics
- Communicate trade-offs to stakeholders
- Prevent new debt with good practices

### Prevention

- Code reviews
- Architecture reviews
- Automated quality checks
- Adequate testing
- Documentation

---

## Handling Underperforming Team Members

### Performance Identification

- Missed deadlines consistently
- Low code quality
- Lack of participation
- Negative attitude
- Not meeting expectations

### Approach

1. Private conversation
2. Understand root cause
3. Provide specific feedback
4. Create improvement plan
5. Set clear expectations
6. Regular check-ins
7. Provide support and resources
8. Document conversations

### Improvement Plan

- Specific, measurable goals
- Timeline for improvement
- Support and resources
- Regular feedback sessions
- Consequences if not improved

### Performance Escalation

- HR involvement if needed
- Performance improvement plan (PIP)
- Reassignment if appropriate
- Termination as last resort

### Performance Prevention

- Clear expectations from start
- Regular feedback
- Support and resources
- Recognition of good work
- Positive team culture

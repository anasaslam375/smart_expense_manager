# UI Components Specification

## Overview

This specification defines the UI components that must be implemented consistently across all platforms to ensure a unified user experience.

## Core Components

### ExpenseListScreen

**Purpose**: Display list of expenses with filtering and total amount

**Required Elements**:

- Top app bar with title "My Expenses"
- Total amount card showing sum of all expenses
- Category filter row with horizontal scrolling
- Expense list with cards
- Floating action button for adding expenses
- Empty state when no expenses exist
- Loading state indicator
- Error state with retry option

**Layout**:

- Top bar at top (56dp height)
- Total amount card below top bar (120dp height)
- Category filter row below total card (48dp height)
- Expense list fills remaining space
- FAB at bottom-right (56dp size)

**Behavior**:

- Auto-load expenses on screen appear
- Filter by category on selection
- Show loading indicator during operations
- Refresh on pull-to-refresh
- Scroll to top on new expense added

### ExpenseCard

**Purpose**: Display individual expense information

**Required Elements**:

- Category icon in colored circle (50dp)
- Category name
- Expense amount
- Date display (relative format)
- Optional note preview
- Delete button (icon)

**Layout**:

- Horizontal row with icon on left
- Details in middle column
- Amount and delete on right
- Card height: 80dp
- Corner radius: 16dp
- Elevation: 2dp

**Color Scheme**:

- Background: White (light), Surface (dark)
- Category icon background: Category color with 20% opacity
- Amount text: Primary color
- Delete icon: Error color

**Interactions**:

- Tap to view details (optional)
- Long press to show delete confirmation
- Swipe to delete (platform-specific)

### TotalAmountCard

**Purpose**: Display total spending amount

**Required Elements**:

- "Total Spent" label
- Total amount in currency format
- Background color: Primary color
- Text color: White

**Layout**:

- Full width with 16dp horizontal padding
- Height: 120dp
- Corner radius: 20dp
- Vertical padding: 20dp

**Typography**:

- Label: Body medium, 70% opacity
- Amount: Headline large, bold

### CategoryFilterRow

**Purpose**: Filter expenses by category

**Required Elements**:

- "All" filter chip
- Category filter chips for default categories
- Horizontal scrolling
- Selected state indication

**Layout**:

- Horizontal row with 8dp spacing
- Chip height: 40dp
- Horizontal padding: 16dp
- Vertical padding: 8dp

**Behavior**:

- Single selection only
- Clear filter on "All" selection
- Auto-scroll to selected category

### AddExpenseBottomSheet

**Purpose**: Form for adding new expenses

**Required Elements**:

- Amount input field
- Category selection (emoji chips)
- Note input (optional)
- Date picker
- Add button
- Cancel button

**Layout**:

- Full width dialog
- Corner radius: 20dp
- Padding: 24dp
- Vertical scrollable content

**Form Fields**:

- Amount: Decimal keyboard, required
- Category: Single selection, required
- Note: Text field, optional, max 500 chars
- Date: Date picker, default to today

**Validation**:

- Amount > 0
- Category selected
- Date not in future
- Disable add button until valid

### EmptyState

**Purpose**: Display when no expenses exist

**Required Elements**:

- "No expenses yet" message
- "Tap the + button to add your first expense" hint
- Optional illustration

**Layout**:

- Centered in available space
- Vertical spacing: 8dp between elements

**Typography**:

- Title: Title large
- Hint: Body medium, 60% opacity

### ErrorState

**Purpose**: Display error information

**Required Elements**:

- Error message
- Retry button

**Layout**:

- Centered in available space
- Vertical spacing: 16dp between elements

**Behavior**:

- Retry button triggers reload
- Dismissible on user action

## Design System

### Colors

**Primary Colors**:

- Primary: #6C63FF
- Primary Container: #EADDFF
- On Primary: #FFFFFF

**Secondary Colors**:

- Secondary: #9C27B0
- Secondary Container: #E8DEF8
- On Secondary: #FFFFFF

**Error Colors**:

- Error: #B3261E
- Error Container: #F9DEDC
- On Error: #FFFFFF

**Neutral Colors**:

- Background: #F8F9FA (light), #1A1A2E (dark)
- Surface: #FFFFFF (light), #16213E (dark)
- On Background: #2D3436 (light), #FFFFFF (dark)
- On Surface: #2D3436 (light), #FFFFFF (dark)

### Typography

**Font Families**:

- iOS: SF Pro Display
- Android: Roboto
- Flutter: System default

**Type Scale**:

- Display Large: 57sp/48pt
- Headline Large: 32sp/28pt
- Title Large: 22sp/20pt
- Body Large: 16sp/17pt
- Body Medium: 14sp/15pt
- Label Medium: 12sp/13pt

### Spacing

**Scale**: 4dp base unit

- Extra Small: 4dp
- Small: 8dp
- Medium: 16dp
- Large: 24dp
- Extra Large: 32dp

### Corner Radius

- Small: 8dp
- Medium: 16dp
- Large: 20dp
- Extra Large: 28dp

### Elevation

- Level 1: 1dp
- Level 2: 2dp
- Level 3: 4dp
- Level 4: 8dp

## Platform-Specific Adaptations

### iOS (SwiftUI)

- Use NavigationView for navigation
- Use List for expense list
- Use Sheet for bottom sheet
- Native date picker
- Haptic feedback on actions

### Android (Jetpack Compose)

- Use Scaffold for layout
- Use LazyColumn for expense list
- Use BottomSheetScaffold for bottom sheet
- Material3 date picker
- Ripple effects on touch

### Flutter

- Use Scaffold for layout
- Use ListView for expense list
- Use showModalBottomSheet for bottom sheet
- showDatePicker for date selection
- Platform-specific widgets

## Accessibility

**Minimum Requirements**:

- Minimum touch target: 48dp
- Contrast ratio: 4.5:1 for text
- Screen reader labels for all interactive elements
- Semantic descriptions for images
- Keyboard navigation support

**Screen Reader Labels**:

- "My Expenses" for app bar
- "Total spent [amount]" for total card
- "[Category] expense, [amount], [date]" for expense cards
- "Add expense" for FAB
- "Filter by [category]" for filter chips

## Responsive Design

**Breakpoints**:

- Compact: < 600dp (phones)
- Medium: 600-840dp (tablets portrait)
- Expanded: > 840dp (tablets landscape, desktop)

**Adaptations**:

- Compact: Single column, full-width cards
- Medium: Two columns for expense list
- Expanded: Three columns for expense list

## Animation

**Standard Durations**:

- Fast: 150ms
- Medium: 300ms
- Slow: 500ms

**Animations**:

- Card appearance: Fade in + scale (300ms)
- List item insertion: Slide in (300ms)
- List item deletion: Fade out + shrink (300ms)
- Filter selection: Color transition (150ms)
- Bottom sheet: Slide up (300ms)

## Performance

**Target Metrics**:

- Screen render: < 16ms (60fps)
- List scroll: 60fps minimum
- Animation: 60fps minimum
- Memory: < 100MB for typical usage

**Optimizations**:

- Lazy loading for lists
- Image caching for receipts
- Debounced search/filter
- Virtual scrolling for large lists

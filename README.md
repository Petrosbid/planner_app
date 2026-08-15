# ZedPlan

> **Offline-first Personal Productivity, Planning & Self-Discipline System**

**ZedPlan** is a modern offline-first personal planner designed to help people not only organize their tasks and schedules, but gradually become more consistent, realistic, self-aware, and disciplined.

ZedPlan combines **calendar planning, time blocking, tasks, habits, goals, projects, notes, focus sessions, behavioral analytics, daily/weekly reviews, and adaptive planning** into a single personal productivity system.

It is built with **Flutter** and designed to work primarily offline, with local-first data ownership and optional synchronization capabilities for future versions.

---

## 🇬🇧 English

### 🇮🇷 فارسی

---

# 📌 Table of Contents | فهرست مطالب

* [Overview | معرفی](#overview--معرفی)
* [Vision | چشم‌انداز](#vision--چشم‌انداز)
* [Problem | مسئله](#problem--مسئله)
* [Core Philosophy | فلسفه اصلی](#core-philosophy--فلسفه-اصلی)
* [Key Features | قابلیت‌ها](#key-features--قابلیت‌ها)
* [Behavioral Design | طراحی رفتاری](#behavioral-design--طراحی-رفتاری)
* [Planning System | سیستم برنامه‌ریزی](#planning-system--سیستم-برنامهریزی)
* [Analytics | تحلیل و آمار](#analytics--تحلیل-و-آمار)
* [Architecture | معماری](#architecture--معماری)
* [Offline-First | آفلاین](#offline-first--آفلاین)
* [Technology Stack | تکنولوژی‌ها](#technology-stack--تکنولوژیها)
* [Project Structure | ساختار پروژه](#project-structure--ساختار-پروژه)
* [UI/UX | طراحی رابط](#uiux--طراحی-رابط)
* [Data Model | مدل داده](#data-model--مدل-داده)
* [Privacy | حریم خصوصی](#privacy--حریم-خصوصی)
* [Roadmap | نقشه راه](#roadmap--نقشه-راه)
* [Installation | نصب](#installation--نصب)
* [Development | توسعه](#development--توسعه)
* [Testing | تست](#testing--تست)
* [Contributing | مشارکت](#contributing--مشارکت)
* [License | مجوز](#license--مجوز)

---

# Overview | معرفی

## 🇬🇧 English

Most productivity applications focus on storing tasks and displaying calendars.

ZedPlan takes a different approach.

The goal is to create a **personal behavioral productivity system** that helps users understand:

* What they need to do
* When they should do it
* How much work they can realistically handle
* Whether they are actually following their plans
* Why they postpone tasks
* Which habits are becoming consistent
* Which goals are progressing
* When they are overloading themselves
* When they need recovery
* How their behavior changes over time

ZedPlan is therefore more than a task manager.

It is designed as a **personal planning and self-management system**.

## 🇮🇷 فارسی

بیشتر نرم‌افزارهای Productivity صرفاً روی ذخیره Taskها و نمایش Calendar تمرکز دارند.

ZedPlan رویکرد متفاوتی دارد.

هدف ZedPlan ساخت یک **سیستم بهره‌وری و خودمدیریتی رفتاری** است که به کاربر کمک می‌کند بفهمد:

* چه کارهایی باید انجام دهد
* چه زمانی باید آنها را انجام دهد
* واقعاً چه مقدار کار در روز می‌تواند انجام دهد
* چقدر به برنامه‌های خودش پایبند است
* چرا بعضی کارها را به تعویق می‌اندازد
* کدام عادت‌ها در حال شکل‌گیری هستند
* اهدافش چقدر پیشرفت کرده‌اند
* چه زمانی بیش از ظرفیت خود برنامه‌ریزی کرده است
* چه زمانی نیاز به استراحت و Recovery دارد
* رفتار او در طول زمان چگونه تغییر کرده است

بنابراین ZedPlan صرفاً یک Task Manager نیست.

بلکه به‌عنوان یک **سیستم شخصی برنامه‌ریزی، خودمدیریتی و رشد رفتاری** طراحی شده است.

---

# Vision | چشم‌انداز

## 🇬🇧 English

The long-term vision of ZedPlan is:

> **Help people become better at managing themselves, not merely better at managing tasks.**

The product should gradually teach users:

* realistic planning
* consistency
* prioritization
* self-awareness
* time estimation
* workload management
* habit formation
* reflection
* recovery
* long-term goal management

The application should eventually become a **Personal Operating System**.

## 🇮🇷 فارسی

چشم‌انداز بلندمدت ZedPlan این است:

> **کمک به انسان‌ها برای بهتر مدیریت کردن خودشان، نه فقط بهتر مدیریت کردن Taskها.**

محصول باید به‌تدریج به کاربر کمک کند تا در موارد زیر بهتر شود:

* برنامه‌ریزی واقع‌بینانه
* استمرار
* اولویت‌بندی
* خودآگاهی
* تخمین زمان
* مدیریت حجم کار
* ایجاد عادت
* بازبینی عملکرد
* Recovery
* مدیریت اهداف بلندمدت

در نهایت ZedPlan می‌تواند به یک **Personal Operating System** برای زندگی شخصی تبدیل شود.

---

# Problem | مسئله

## 🇬🇧 English

Traditional planners usually have several problems:

### 1. Overplanning

Users add more tasks than they can realistically complete.

### 2. Lack of feedback

The application records what happened but does not help the user understand why it happened.

### 3. Motivation dependency

Many systems rely heavily on streaks, points, badges, and notifications.

### 4. No behavioral learning

The application does not learn that a user:

* underestimates tasks
* works better at certain times
* frequently postpones certain task types
* becomes overloaded after a certain number of commitments

### 5. Productivity without balance

A user can appear extremely productive while actually being overloaded.

ZedPlan is designed to address these problems.

## 🇮🇷 فارسی

Plannerهای سنتی معمولاً چند مشکل دارند:

### ۱. برنامه‌ریزی بیش از حد

کاربر تعداد بیشتری Task نسبت به ظرفیت واقعی خود ثبت می‌کند.

### ۲. نبود Feedback

برنامه فقط ثبت می‌کند چه اتفاقی افتاده، اما به کاربر کمک نمی‌کند بفهمد چرا این اتفاق افتاده است.

### ۳. وابستگی به Motivation

بسیاری از سیستم‌ها بیش از حد روی Streak، امتیاز، Badge و Notification تکیه می‌کنند.

### ۴. عدم یادگیری رفتاری

برنامه متوجه نمی‌شود که مثلاً کاربر:

* زمان Taskها را کمتر از واقعیت تخمین می‌زند
* در ساعات خاصی عملکرد بهتری دارد
* بعضی Taskها را مرتب به تعویق می‌اندازد
* بعد از تعداد مشخصی Commitment دچار Overload می‌شود

### ۵. بهره‌وری بدون تعادل

ممکن است کاربر ظاهراً بسیار Productivity بالایی داشته باشد، اما در واقع بیش از ظرفیتش کار کند.

ZedPlan برای حل این مشکلات طراحی شده است.

---

# Core Philosophy | فلسفه اصلی

The core behavioral loop of ZedPlan is:

```text
PLAN
  ↓
COMMIT
  ↓
ACT
  ↓
MEASURE
  ↓
REFLECT
  ↓
ADAPT
  ↓
REPEAT
```

### برنامه‌ریزی

کاربر مشخص می‌کند چه کاری می‌خواهد انجام دهد.

### تعهد

مشخص می‌کند چه چیزی واقعاً برایش مهم است.

### اجرا

کار را انجام می‌دهد.

### اندازه‌گیری

سیستم نتیجه را ثبت می‌کند.

### بازبینی

کاربر بررسی می‌کند چه اتفاقی افتاده است.

### تطبیق

برنامه بر اساس تجربه واقعی اصلاح می‌شود.

### تکرار

چرخه دوباره انجام می‌شود.

---

# Key Features | قابلیت‌های اصلی

## 📅 Smart Calendar

### English

* Day view
* 3-day view
* Week view
* Month view
* Time blocking
* Drag & drop scheduling
* Resizable events
* Flexible tasks
* Fixed events
* Workload visualization

### فارسی

* نمایش روزانه
* نمایش سه‌روزه
* نمایش هفتگی
* نمایش ماهانه
* Time Blocking
* جابه‌جایی با Drag & Drop
* تغییر مدت زمان
* Taskهای Flexible
* Eventهای Fixed
* نمایش حجم کار

---

# ✅ Task Management

### English

Tasks support:

* title
* description
* priority
* duration
* deadline
* scheduled time
* recurrence
* tags
* project
* goal
* life area
* energy level
* difficulty
* subtasks
* notes
* reminders
* history

### فارسی

Taskها شامل موارد زیر هستند:

* عنوان
* توضیحات
* اولویت
* مدت زمان
* Deadline
* زمان برنامه‌ریزی‌شده
* تکرار
* Tag
* Project
* Goal
* Life Area
* سطح انرژی
* سختی
* Subtask
* Note
* Reminder
* تاریخچه تغییرات

---

# 🎯 Goals

## English

Goal hierarchy:

```text
Vision
   ↓
Goal
   ↓
Milestone
   ↓
Project
   ↓
Task
   ↓
Action
```

This structure connects daily actions with long-term objectives.

## فارسی

ساختار اهداف:

```text
Vision
   ↓
Goal
   ↓
Milestone
   ↓
Project
   ↓
Task
   ↓
Action
```

این ساختار باعث می‌شود اقدامات روزانه به اهداف بلندمدت متصل شوند.

---

# 📁 Projects

Projects provide a middle layer between goals and tasks.

Features:

* Project overview
* Progress
* Milestones
* Tasks
* Timeline
* Notes
* Goal connection
* Deadline
* Project statistics

---

# 🔁 Habits

## English

Habit tracking focuses on **consistency rather than punishment**.

Metrics include:

* completion rate
* consistency
* frequency
* recovery
* weekly trend
* monthly trend
* calendar history

Streaks may exist, but they should never become the central measurement of success.

## فارسی

سیستم Habit روی **استمرار، نه تنبیه** تمرکز دارد.

شاخص‌ها:

* Completion Rate
* Consistency
* Frequency
* Recovery
* روند هفتگی
* روند ماهانه
* تاریخچه Calendar

Streak می‌تواند وجود داشته باشد، اما نباید معیار اصلی موفقیت کاربر باشد.

---

# 📝 Notes

## English

ZedPlan includes a lightweight block-based note system.

Supported blocks may include:

* Text
* Heading
* Checklist
* Bullet list
* Numbered list
* Quote
* Callout
* Table
* Code
* Image
* Link

Notes can be associated with:

* tasks
* projects
* goals
* habits
* events

## فارسی

ZedPlan دارای سیستم Notes مبتنی بر Block است.

Blockهای قابل پشتیبانی:

* متن
* Heading
* Checklist
* Bullet List
* Numbered List
* Quote
* Callout
* Table
* Code
* Image
* Link

Noteها می‌توانند به موارد زیر متصل شوند:

* Task
* Project
* Goal
* Habit
* Event

---

# 🧠 Behavioral Design | طراحی رفتاری

ZedPlan is intentionally designed around behavioral reinforcement.

The system should encourage:

```text
Clarity
↓
Commitment
↓
Action
↓
Feedback
↓
Reflection
↓
Improvement
```

## Important behavioral mechanisms

### Commitment

Users can explicitly commit to important tasks.

### Capacity awareness

The system estimates how much work the user is planning relative to available time.

### Postponement analysis

Repeatedly postponed tasks can trigger reflective prompts.

### Minimum Viable Day

Users can protect essential behaviors even during difficult days.

### Daily Review

Users can identify what went well and what failed.

### Weekly Experiment

Instead of giving dozens of recommendations, the system can suggest one small behavioral improvement per week.

---

# 📊 Analytics | تحلیل و آمار

Analytics are one of the core features of ZedPlan.

The objective is not to create attractive charts for their own sake.

Every chart should answer a useful question.

---

## Planned vs Actual

```text
Planned: 6h
Actual: 7h 30m
```

This helps users improve their time estimation.

---

## Execution Rate

```text
Planned Tasks: 40
Completed: 34

Execution Rate: 85%
```

---

## Commitment Reliability

```text
Committed: 20
Kept: 17

Reliability: 85%
```

---

## Planning Accuracy

Compare estimated duration against actual duration.

Example:

```text
Estimated: 60 min
Actual: 95 min

Variance: +35 min
```

After enough historical data, ZedPlan can identify patterns such as:

> Programming tasks are usually underestimated.

---

## Workload Analysis

Analyze:

* available time
* scheduled time
* commitment time
* focus time
* recovery time

The system should help users identify overplanning.

---

# Self-Reliability

Self-Reliability measures behavioral consistency.

Example:

```text
SELF-RELIABILITY

84%

+11% compared with last month
```

This represents observed behavior, not personal worth.

The application must never turn behavioral metrics into judgments about a user's identity or value.

---

# ⚖️ Balance

Productivity should not mean working endlessly.

ZedPlan should track:

* workload
* focus
* rest
* recovery
* schedule density
* overcommitment

If workload becomes unusually high, the application should provide a gentle warning.

---

# 🔍 Behavioral Insights

Over time the application can identify patterns such as:

```text
You complete difficult tasks more often before noon.

You frequently underestimate tasks longer than 90 minutes.

Your completion rate is higher on days with fewer major commitments.

You tend to postpone tasks with low clarity.
```

Insights should be presented as observations rather than psychological diagnoses.

---

# 📆 Daily Review

At the end of each day:

```text
Completed
Incomplete
Postponed
```

Then:

```text
Energy: 1–5
Focus: 1–5
```

Possible obstacles:

* Too many tasks
* Low energy
* Distraction
* Unexpected work
* Poor estimation
* Lack of clarity
* Other

The review should take approximately 1–2 minutes.

---

# 📅 Weekly Review

The weekly review summarizes:

* tasks planned
* tasks completed
* commitments kept
* habit consistency
* focus time
* overloaded days
* planning accuracy
* behavioral patterns

Then the application can suggest:

```text
NEXT WEEK EXPERIMENT

Reduce daily planned workload by 20%.
```

The user can accept or reject the experiment.

---

# 🗓️ Monthly Review

Monthly analytics include:

* productivity trend
* habit consistency
* goal progress
* focus time
* planning accuracy
* commitment reliability
* workload
* recovery
* life-area balance

Comparisons:

```text
↑ Improved
→ Stable
↓ Declined
```

---

# 🧩 Templates

Built-in templates can include:

* Daily Planner
* Weekly Planner
* Student Planner
* Study Plan
* Exam Preparation
* Project Planner
* Habit Builder
* Morning Routine
* Evening Routine
* Personal Project
* Content Creation

Users can create custom templates.

---

# 🗂️ Life Areas

Default Life Areas:

* Health
* Learning
* Career
* Personal
* Relationships
* Finance
* Creative
* Other

Users can create custom areas.

Analytics can show how time and attention are distributed across life areas.

---

# 🔎 Universal Search

Search across:

* Tasks
* Notes
* Goals
* Projects
* Habits
* Events
* Templates

Search should work fully offline.

---

# ⚡ Quick Actions

A global Quick Create button provides:

```text
+ Task
+ Event
+ Habit
+ Goal
+ Note
+ Project
+ Focus Session
```

Creation should require as few interactions as possible.

---

# 🎯 Focus Mode

Focus Mode provides a distraction-free environment.

Display:

* current task
* timer
* progress
* pause
* finish

When Focus Mode starts, unnecessary navigation should disappear.

---

# 📱 UI/UX

## Design Principles

ZedPlan follows:

* modern
* minimal
* premium
* calm
* accessible
* responsive
* human-centered
* data-driven

The design should be visually inspired by the best modern productivity products while maintaining a completely unique visual identity.

---

# 🎨 Design System

The design system includes:

### Colors

* Primary
* Secondary
* Background
* Surface
* Elevated Surface
* Text
* Border
* Success
* Warning
* Error
* Info

### Typography

* Display
* Heading
* Title
* Body
* Caption
* Label
* Numeric

### Components

* Buttons
* Cards
* Task rows
* Calendar blocks
* Tabs
* Chips
* Progress bars
* Progress rings
* Charts
* Bottom sheets
* Dialogs
* Snackbars
* Tooltips
* Inputs
* Selectors

---

# 🌙 Dark Mode

ZedPlan supports a fully designed dark mode.

Dark mode is not simply an inverted light theme.

It should use:

* appropriate surface hierarchy
* controlled contrast
* subtle borders
* readable charts
* accessible text
* reduced visual fatigue

---

# 🌍 Internationalization

ZedPlan is designed for multilingual support.

Initial targets:

* English
* Persian

The architecture should support additional languages in the future.

RTL layouts must be treated as first-class layouts rather than a simple text-direction switch.

---

# ♿ Accessibility

The application should support:

* Dynamic text size
* Screen readers
* High contrast
* Large touch targets
* Reduced motion
* Color-independent status indicators
* Keyboard navigation where applicable
* RTL
* Accessible charts

---

# 📴 Offline-First

Offline operation is a fundamental architectural principle.

Core functionality must work without an internet connection.

Offline features include:

* Tasks
* Calendar
* Habits
* Goals
* Projects
* Notes
* Analytics
* Focus sessions
* Reviews
* Templates
* Search
* Notifications

The user should never need an internet connection for basic productivity.

---

# 🔐 Privacy

ZedPlan is designed around local data ownership.

Potential privacy features:

* App Lock
* PIN
* Biometric authentication
* Local encryption
* Local backup
* Import
* Export

Cloud synchronization, if introduced later, should be optional.

---

# 🏗️ Architecture

ZedPlan should follow a scalable architecture suitable for a large Flutter application.

Recommended architectural approach:

```text
Presentation
     ↓
Application / State Management
     ↓
Domain
     ↓
Data
     ↓
Local Database
```

The architecture should follow clean separation of concerns.

---

# 📦 Technology Stack

## Frontend

**Flutter / Dart**

Target platforms:

* Android
* iOS
* Tablet

Future:

* Web
* Desktop

---

## Local Database

The database layer should be abstracted behind repositories.

Potential implementations include:

* SQLite
* Drift
* Isar
* Hive

The final database should be selected based on:

* query capability
* reliability
* transaction support
* offline performance
* migration support
* Flutter compatibility
* long-term maintainability

---

## State Management

The application should use a scalable reactive state-management architecture.

Potential choices:

* Riverpod
* BLoC
* Cubit

The selected solution should provide:

* predictable state
* testability
* dependency injection
* separation of UI and business logic

---

# 📁 Project Structure

A recommended structure:

```text
lib/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── localization/
│   ├── routing/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── features/
│
│   ├── onboarding/
│   ├── home/
│   ├── tasks/
│   ├── calendar/
│   ├── habits/
│   ├── goals/
│   ├── projects/
│   ├── notes/
│   ├── focus/
│   ├── reviews/
│   ├── analytics/
│   ├── insights/
│   ├── templates/
│   ├── search/
│   ├── notifications/
│   └── settings/
│
├── data/
│   ├── database/
│   ├── repositories/
│   ├── models/
│   └── datasources/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── main.dart
```

Feature boundaries should remain independent wherever possible.

---

# 🗄️ Data Model

Core entities include:

```text
User
LifeArea
Goal
Milestone
Project
Task
Subtask
Habit
HabitEntry
CalendarEvent
TimeBlock
FocusSession
Note
NoteBlock
Template
Reminder
DailyReview
WeeklyReview
MonthlyReview
Insight
Metric
Tag
```

Relationships:

```text
LifeArea
   ↓
Goal
   ↓
Milestone
   ↓
Project
   ↓
Task
   ↓
Subtask
```

Additional relationships:

```text
Task → FocusSession
Task → Note
Task → Habit
Task → CalendarEvent
Goal → Project
Goal → Task
Project → Note
```

---

# 🔄 Repository Pattern

The UI must not directly access the database.

Use:

```text
UI
 ↓
Controller / ViewModel
 ↓
Use Case
 ↓
Repository
 ↓
Data Source
 ↓
Database
```

This allows the database implementation to change without rewriting the UI.

---

# 🧠 Analytics Engine

Analytics should be calculated from raw behavioral data.

Examples:

```text
Execution Rate
= completed tasks / planned tasks

Commitment Reliability
= kept commitments / total commitments

Planning Accuracy
= actual duration vs estimated duration

Habit Consistency
= completed occurrences / expected occurrences
```

More advanced analytics can later include:

* rolling averages
* trend detection
* workload prediction
* time estimation correction
* schedule optimization
* behavioral pattern detection

---

# 🤖 Future Intelligence Layer

Future versions may include an optional local or remote AI layer.

Potential capabilities:

* intelligent task breakdown
* schedule suggestions
* natural-language planning
* automatic task categorization
* behavioral summaries
* personalized planning suggestions
* goal decomposition
* note summarization
* semantic search

AI should remain an optional layer.

The core planner must work without AI.

---

# 🔔 Notification System

Notifications should be contextual.

Examples:

```text
Your next task starts in 15 minutes.

You have 3 important commitments today.

Your schedule looks unusually full.

Your day is almost complete. Review it?
```

Users must be able to customize notification behavior.

---

# 🛡️ Error Handling

The application should never expose raw exceptions to users.

Instead of:

```text
DatabaseException: constraint failed
```

display:

```text
Something went wrong while saving this item.

Your data is still safe.

[Try Again]
```

Errors should be logged internally for debugging.

---

# 🧪 Testing Strategy

The project should include:

### Unit Tests

For:

* business logic
* calculations
* analytics
* scheduling
* habit logic
* date/time logic

### Widget Tests

For:

* components
* forms
* task interactions
* calendar interactions

### Integration Tests

For:

* onboarding
* task creation
* scheduling
* focus
* reviews
* backup/restore

### Database Tests

For:

* migrations
* transactions
* CRUD
* data integrity

---

# 📦 Backup & Restore

Users should be able to export their local data.

Potential formats:

```text
JSON
ZIP
CSV
```

Depending on the data type.

Backup should include:

* tasks
* goals
* projects
* habits
* notes
* reviews
* settings
* templates

Restore should validate imported data before modifying the current database.

---

# 🔒 Data Safety

The application should prioritize:

* local persistence
* database transactions
* migrations
* validation
* backup
* restore
* corruption recovery

No single failed feature should cause loss of unrelated user data.

---

# 🚀 Installation

## Requirements

Recommended:

```text
Flutter SDK
Dart SDK
Android Studio or VS Code
Android SDK
Xcode (for iOS development)
```

Check Flutter:

```bash
flutter doctor
```

Clone:

```bash
git clone https://github.com/your-username/zedplan.git
```

Enter:

```bash
cd zedplan
```

Install dependencies:

```bash
flutter pub get
```

Run:

```bash
flutter run
```

---

# 🛠️ Development

Recommended development workflow:

```text
Feature
 ↓
Domain model
 ↓
Use case
 ↓
Repository
 ↓
Database
 ↓
State management
 ↓
UI
 ↓
Tests
```

Avoid putting business logic directly inside widgets.

---

# 📐 Coding Principles

Follow:

* SOLID
* DRY
* KISS
* Separation of concerns
* Dependency inversion
* Immutable state where practical
* Testable business logic
* Small reusable widgets
* Feature-based architecture

Avoid:

* massive widgets
* global mutable state
* database calls directly from UI
* duplicated business logic
* hard-coded strings
* hard-coded colors
* hard-coded dimensions

---

# 🎨 Design Principles for Developers

Developers should not create arbitrary UI values.

Use the Design System:

```text
Colors
Typography
Spacing
Radius
Elevation
Components
Animation
```

Every feature should reuse existing components whenever possible.

---

# 🗺️ Roadmap

## Phase 1 — Foundation

* [ ] Flutter project
* [ ] Design system
* [ ] Theme
* [ ] Routing
* [ ] Local database
* [ ] State management
* [ ] Localization
* [ ] Basic architecture

---

## Phase 2 — Core Planner

* [ ] Tasks
* [ ] Calendar
* [ ] Time blocking
* [ ] Quick create
* [ ] Reminders
* [ ] Recurring tasks
* [ ] Today screen

---

## Phase 3 — Personal Management

* [ ] Goals
* [ ] Projects
* [ ] Habits
* [ ] Notes
* [ ] Focus Mode
* [ ] Templates

---

## Phase 4 — Behavioral System

* [ ] Commitments
* [ ] Daily Review
* [ ] Weekly Review
* [ ] Monthly Review
* [ ] Minimum Day
* [ ] Postponement analysis
* [ ] Capacity analysis

---

## Phase 5 — Analytics

* [ ] Productivity analytics
* [ ] Habit analytics
* [ ] Planning accuracy
* [ ] Commitment reliability
* [ ] Workload analytics
* [ ] Goal analytics
* [ ] Life-area analytics
* [ ] Behavioral insights

---

## Phase 6 — Advanced Intelligence

* [ ] Smart scheduling
* [ ] Adaptive planning
* [ ] AI task breakdown
* [ ] Natural-language planning
* [ ] Intelligent insights
* [ ] Semantic search

---

## Phase 7 — Optional Sync

* [ ] Cloud backup
* [ ] Multi-device sync
* [ ] Conflict resolution
* [ ] Account system
* [ ] End-to-end encryption

Cloud synchronization should remain optional and should never compromise the offline-first philosophy.

---

# 🧭 Product Success Metrics

ZedPlan should not measure success only by:

```text
Number of tasks
Number of sessions
Time spent inside the app
```

Better product metrics include:

### Planning Accuracy

Are users becoming better at estimating their capacity?

### Commitment Reliability

Are users becoming more consistent?

### Completion Quality

Are users completing meaningful tasks?

### Habit Consistency

Are routines becoming more stable?

### Overplanning Reduction

Are users creating more realistic schedules?

### Recovery

Can users return to their routine after disrupted days?

### Goal Progress

Are daily actions contributing to meaningful goals?

The product should ultimately encourage users to need the app **less for motivation and more for clarity and self-management**.

---

# 🌱 Long-Term Product Philosophy

ZedPlan should not create dependency.

The ultimate goal is:

```text
User needs motivation
        ↓
User uses ZedPlan
        ↓
User learns patterns
        ↓
User learns realistic planning
        ↓
User builds consistency
        ↓
User becomes more self-aware
        ↓
User manages themselves better
```

The product succeeds when the user's behavior improves.

Not when the user spends more time inside the application.

---

# 🤝 Contributing

Contributions are welcome.

Before submitting a Pull Request:

1. Create a feature branch.
2. Follow the architecture.
3. Add tests.
4. Follow the design system.
5. Keep changes focused.
6. Update documentation where necessary.

Example:

```bash
git checkout -b feature/habit-analytics
```

Commit:

```bash
git commit -m "feat: add habit analytics"
```

Push:

```bash
git push origin feature/habit-analytics
```

Then open a Pull Request.

---

# 📝 Commit Convention

Use Conventional Commits:

```text
feat:
fix:
refactor:
docs:
test:
perf:
chore:
style:
```

Examples:

```text
feat: add weekly review
fix: resolve calendar timezone issue
refactor: improve task repository
test: add habit calculation tests
docs: update architecture documentation
```

---

# 📄 License

Choose an appropriate open-source or proprietary license before public release.

Example:

```text
MIT License
```

or a proprietary license if ZedPlan is intended to become a commercial product.

---

# ⭐ Final Product Definition

ZedPlan is not simply:

```text
Todo App
```

It is not simply:

```text
Calendar
```

It is not simply:

```text
Habit Tracker
```

It is not simply:

```text
Note-taking App
```

It is not simply:

```text
Analytics Dashboard
```

ZedPlan combines them into one coherent system:

```text
                 ZEDPLAN
                    │
        ┌───────────┼───────────┐
        ↓           ↓           ↓
      PLAN         ACT        REFLECT
        │           │           │
        ↓           ↓           ↓
    Calendar      Tasks       Reviews
    Time Blocks   Focus       Analytics
    Goals         Habits      Insights
    Projects      Routines    Adaptation
        │           │           │
        └───────────┼───────────┘
                    ↓
              SELF MANAGEMENT
                    ↓
                CONSISTENCY
                    ↓
              LONG-TERM GROWTH
```

### 🇬🇧 English

> **Plan realistically. Commit intentionally. Act consistently. Learn from yourself. Adapt continuously.**

### 🇮🇷 فارسی

> **واقع‌بینانه برنامه‌ریزی کن، آگاهانه متعهد شو، مستمر عمل کن، از خودت یاد بگیر و دائماً سازگار شو.**

---

## Project Status

🚧 **Early Development**

The architecture, product specification, UX system, and feature roadmap are actively evolving.

The project is currently focused on building a strong offline-first foundation before introducing advanced intelligence and synchronization features.

---

## ZedPlan

**A planner that doesn't just organize your life — it helps you learn how to manage it.**

**برنامه‌ریزی که فقط زندگی تو را سازمان‌دهی نمی‌کند؛ بلکه به تو کمک می‌کند یاد بگیری چگونه آن را مدیریت کنی.**

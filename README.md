<div align="center">

# 🌙 ZedPlan

### Offline-first personal planner, built around behavior — not just tasks.

**Plan realistically · Commit intentionally · Act consistently · Learn from yourself**

[![Flutter](https://img.shields.io/badge/Flutter-3.4+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green)](https://flutter.dev)
[![Localization](https://img.shields.io/badge/Lang-فارسی%20%7C%20English-blueviolet)](https://github.com/your-username/zedplan)


*واقع‌بینانه برنامه‌ریزی کن، آگاهانه متعهد شو، مستمر عمل کن، از خودت یاد بگیر.*

</div>

---
## 📸 Screenshots

<img width="813" height="1280" alt="13" src="https://github.com/user-attachments/assets/99096607-bcdd-4413-a511-4ce981acd629" />
<img width="817" height="1280" alt="9" src="https://github.com/user-attachments/assets/f56e2ab4-1059-47da-8797-2ed9a92d1cd1" />
<img width="820" height="1280" alt="6" src="https://github.com/user-attachments/assets/5f876abd-3e33-48b3-8d03-d6d43ddac335" />
<img width="786" height="1280" alt="5" src="https://github.com/user-attachments/assets/cf75e47f-4a2b-4631-918b-3719aa66400d" />
<img width="825" height="1280" alt="4" src="https://github.com/user-attachments/assets/f32be7c4-5be9-4f87-85dd-4c6d23551d34" />

---
## 📖 About

ZedPlan is a **real, working planner** — not a mockup. Everything you create is stored on your device and survives restarts. It combines calendar time-blocking, tasks, habits, focus sessions, reviews, and behavioral analytics into one calm, bilingual (Persian/English, RTL-first) experience with full **Jalali & Gregorian calendar** support.

The core loop it encourages:

```text
PLAN → COMMIT → ACT → MEASURE → REFLECT → ADAPT → REPEAT
```

---

## ✨ Features

### 🗓 Calendar & Time Blocking
- **24-hour timeline** with Day / 3-Day / Week / Month views
- Time blocks with **custom categories** (built-in: Deep Work, Meeting, Review — add your own with stable colors)
- **Conflict detection** — overlapping blocks are rejected; back-to-back is fine
- Capacity awareness: planned hours vs. a useful daily capacity, with a dismissible breakdown sheet
- Live "now" indicator, auto-scroll to current hour, Jalali month grid

### ✅ Tasks
- Quick capture with **custom estimated time**, priority, and commitment flag
- Filters (all / pending / done), swipe-to-delete with undo, animated completion
- Per-task detail: edit, commitments, and **"why wasn't this done?"** recording

### 🎯 Outcome Submission & Distractions
- Every time block gets an explicit outcome: **Done ✓ / Not done ✕**
- Not-done blocks and pending tasks prompt for a **reason** — 7 built-in options (phone, low energy, environment, unexpected work, clarity, motivation, other) **plus your own custom reasons**
- The focus screen's interruption logger feeds the same system

### 📊 Behavioral Analytics
- Execution rate & commitment reliability (computed from *your* data)
- Focus time by category (donut) and weekly focus bars
- **Weekly distraction analysis**: per-day chart + most frequent reasons ranking

### 🔁 Habits, Goals, Projects & Notes
- Habits: one-tap daily check (also on Home), streaks, 30-day heatmap
- Goals & Projects: description, animated progress, full edit sheets
- Notes: search, create/edit/delete

### 🧘 Focus Mode
- Pomodoro / Deep Work / Breaks / custom durations, zen mode
- Sessions are **recorded** and roll into daily stats and analytics

### 📝 Reviews
- 4-step daily review (accomplishments → energy/focus → obstacles → reflection) that actually saves
- Weekly review computed from real data, with a distraction summary

### 🔔 Notifications
- **Block started** → "وقت تمرکز است!"
- **Block ended** → *"Did you do it?"* + the next block of the day
- **Daily wrap-up** at 21:00 → check habits, submit outcomes, do your review
- Master on/off switch in Settings; survives reboots; colorized with your theme color

### 🎨 Design & UX
- **Pick your app color** — 10-swatch palette, whole UI re-themes instantly (blue by default)
- Full **dark & light mode**, skeleton loading screens, friendly empty states everywhere
- Tasteful animations: staggered entrances, animated progress rings, springy onboarding
- First-launch **onboarding slider**: intro → your name → theme choice
- Profile & settings with real stats (tasks done, focus minutes, best streak)

---

## 🌍 Localization & Calendars

| | |
|---|---|
| Languages | فارسی (RTL, default) · English |
| Calendars | **Jalali (Solar Hijri)** · Gregorian — switchable in Settings, dates everywhere follow your choice |
| Digits | Persian digits throughout when in Persian |

---

## 🏗 Architecture

Clean layered structure with testable pure logic:

```text
Presentation (features/* screens + core/widgets)
        ↓ ListenableBuilder / AppScope
Application (ChangeNotifier controllers)
        ↓
Domain (pure planners & engines: notifications, dates, stats)
        ↓
Data (PlannerStore — JSON-persisted models via SharedPreferences)
```

- `AppSettings` / `PlannerStore` — ChangeNotifier controllers, persisted
- `AppScope` — lightweight inherited scope (no DI framework needed)
- Notification content, date formatting, and analytics math live in **pure, unit-tested classes**
- The store API is shaped so the existing **Drift schema** can replace it without touching screens

```text
lib/
├── core/            # theme (dynamic colors), controllers, notifications, utils, widgets
├── data/
│   ├── database/    # Drift schema (18 tables) — ready for the DB migration
│   └── models/      # JSON-serializable models
└── features/        # home, calendar, tasks, focus, habits, goals, projects,
                     # notes, reviews, analytics, profile, onboarding, common
```

---

## 🚀 Getting Started

```bash
git clone https://github.com/your-username/zedplan.git
cd zedplan/planner_app
flutter pub get
flutter run          # use a real device for notifications
```

**Tests**

```bash
flutter analyze
flutter test         # 43 tests: store persistence, date/Jalali math,
                     # notification planning, widget flows
```

---

## 🗺 Roadmap

**Done ✅** 
— real persisted data 
· dark/light + custom color 
· Jalali/Gregorian 
· 24h time blocking with categories & conflict checks 
· outcomes & distraction analytics 
· habits/goals/projects/notes 
· focus recording 
· daily/weekly reviews 
· notifications 
· onboarding 
· skeletons & animations

**Next 🔜**
- [ ] Drift (SQLite) database behind the store
- [ ] Recurring tasks & subtasks
- [ ] Reminders per task · custom reminder times
- [ ] Backup / export / import (JSON)
- [ ] Universal search
- [ ] Goal → milestone → project → task hierarchy
- [ ] Optional sync & AI layer (README vision, Phase 6–7)

---

## 📦 Publish-ready description

> **Short (GitHub "About" field):**
>
> *Offline-first behavioral planner — bilingual (فارسی/English), Jalali & Gregorian calendars, 24h time blocking, habits, focus sessions, distraction analytics & smart notifications. Built with Flutter.*

<details>
<summary><b>Longer description (release notes / store listing)</b></summary>

ZedPlan helps you plan realistically and understand your own behavior. Block your 24-hour day with custom categories, submit what actually got done, and record *why* when it didn't — then watch your weekly distraction patterns, execution rate, and commitment reliability take shape from real data. Build habits with streaks and heatmaps, run distraction-free focus sessions, and close every day with a 1-minute review. Fully offline, beautifully animated, dark/light themes with your own accent color, Persian-first with English support, and both Jalali and Gregorian calendars everywhere.

</details>

**Suggested topics:** `flutter` · `planner` · `productivity` · `persian` · `jalali-calendar` · `offline-first` · `time-blocking` · `habit-tracker` · `behavioral-analytics`

---

## 🤝 Contributing

1. Fork & branch (`feat/your-feature`)
2. Follow the existing architecture & design tokens
3. Add tests · keep `flutter analyze` clean
4. Conventional commits (`feat:`, `fix:`, `docs:` …)

---



<div align="center">

**ZedPlan** — a planner that doesn't just organize your life; it helps you learn how to manage it.

*برنامه‌ریزی که فقط زندگی تو را سازمان‌دهی نمی‌کند؛ به تو کمک می‌کند یاد بگیری چگونه آن را مدیریت کنی.*

</div>

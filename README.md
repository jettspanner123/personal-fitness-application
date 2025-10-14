# 🏋️‍♂️ FitAI — Personal AI Fitness App

**FitAI** is an AI-powered personal fitness application built with **SwiftUI** and **Supabase**.  
It generates personalized workouts, tracks training, recommends diets, estimates macros from meal photos, provides an AI workout journal, and includes a rest timer for between sets.

---

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture Overview](#architecture-overview)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Environment Variables](#environment-variables)
  - [Database Setup (Supabase)](#database-setup-supabase)
- [Usage](#usage)
  - [Auth & Onboarding](#auth--onboarding)
  - [Generating Workouts](#generating-workouts)
  - [Tracking Workouts](#tracking-workouts)
  - [Food Photo → Macros](#food-photo--macros)
  - [AI Workout Journal](#ai-workout-journal)
  - [Rest Timer](#rest-timer)
- [Data Model (suggested)](#data-model-suggested)
- [Security & Privacy](#security--privacy)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Features
- **AI Workout Generator**: Custom workout plans based on goals, experience, time, and available equipment.
- **Workout Tracker**: Log sets, reps, weight, RPE; view history and simple analytics.
- **Diet Recommendations**: AI-driven meal plans and macro targets for goals (cut, bulk, maintain).
- **Food Photo Macro Estimation**: Upload a meal photo; AI estimates items & macros.
- **AI Workout Journal**: Auto-summarize sessions, suggest adjustments, and generate notes.
- **Rest Timer**: Per-set rest timer with start/pause/reset and audible/visual cues.
- **Auth & Sync**: Email/SSO auth using Supabase; data synced cross-device via Supabase.

---

## Tech Stack
- Frontend: **SwiftUI** (iOS 18+ recommended)
- Backend / Database: **Supabase** (Postgres + Auth + Storage)
- AI & Vision: — Google Generative AI 
- Local caching & offline: SwiftData 

---

## Architecture Overview
1. **Client (SwiftUI)**  
   - UI, timers, camera capture, local validation, offline queueing.
2. **Supabase**  
   - Authentication, Postgres tables for users/workouts/meals/journal, storage for photos.
3. **AI Services**  
   - Workout generation, diet recommendations, and photo-to-macros. Could be remote API calls or hybrid on-device.
4. **Sync & Background**  
   - Sync user actions to Supabase; handle failed uploads with retry queue.

---

## Getting Started

### Requirements
- Xcode 18+ (or latest supporting your SwiftUI targets)
- iOS 18+ SDK
- A Supabase project
- API keys for chosen AI provider(s)

### Installation
1. Clone the repo:
   ```bash
   git clone https://your-repo-url.git
   cd FitAI


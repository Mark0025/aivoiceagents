# Plan 2 v0.01: Step-by-Step Learning and Testing Plan

## Overview

This plan is designed to guide development in small, testable steps, with a focus on learning Python (with JS comparisons), verifying each step, and committing only when the code is working.

---

## Steps

1. **Define the goal and requirements for this plan.**
2. **Break down the work into small, logical steps.**
3. **For each step:**
   - Explain the concept (with Python/JS comparison if helpful)
   - Write the code
   - Test the code and document the result
   - Only commit if the code works as expected
4. **Push the plan and code to GitHub.**

---

## Testing and Verification

- For each step, describe how you tested the code (manual test, script, etc.)
- Include test results or screenshots if possible
- Only mark a step as complete when it passes its test

---

## Commit and Push

- Commit with a clear message describing what was done and why
- Push to GitHub when the plan or feature is complete and tested

---

## Example Step

### Step: Create a Python virtual environment

- **Concept:** Python virtual environments are like Node.js's `node_modules` isolation, but for Python packages.
- **Code:**
  ```sh
  python3 -m venv venv
  source venv/bin/activate
  ```
- **Test:**
  - Run `which python` and ensure it points to the venv directory
- **Commit:**
  - `git add . && git commit -m "Set up Python virtual environment"`

---

## Next Steps

- Use this plan as a template for all future work
- Always version your plans and never overwrite previous versions

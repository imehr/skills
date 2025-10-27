# Learner Guide Command

Interactive guide to using the Amplifier Learner Tools in Claude Code.

## Usage

```bash
/learner-guide
```

Shows interactive menu to learn about and use learner tools.

## Main Menu

```bash
/learner-guide

╔════════════════════════════════════════════════════════════════╗
║          AMPLIFIER LEARNER TOOLS - CLAUDE CODE GUIDE           ║
╚════════════════════════════════════════════════════════════════╝

What would you like to do?

1. 📚 Learn about the 4 learners
2. 🚀 Quick start with a learner
3. 📋 Available commands
4. 💡 Example workflows
5. 🔧 Troubleshooting
6. 📖 Full documentation

Select (1-6): _
```

## 1. Learn About Learners

```bash
Select: 1

╔════════════════════════════════════════════════════════════════╗
║                    THE 4 LEARNER TOOLS                         ║
╚════════════════════════════════════════════════════════════════╝

🔹 DECISION HISTORIAN
   Learns which decisions work best in specific contexts

   Log: context, decision, outcome
   Output: recommendations per context
   Use when: Your recipe makes strategic choices

   Example: Deciding research depth based on topic difficulty

🔹 STYLE LEARNER
   Learns personal writing voice and preferences from edits

   Log: prompt, output, edits
   Output: formality, perspective, vocabulary profile
   Use when: Generating text users edit to match their style

   Example: Email writing that learns your tone

🔹 META-RECIPE TUNER
   Learns pipeline performance and identifies bottlenecks

   Log: recipe, stage, duration, quality
   Output: bottleneck identification, performance trends
   Use when: Optimizing multi-stage recipe pipelines

   Example: Blog writer pipeline with research + drafting stages

🔹 KNOWLEDGE COMPRESSOR
   Learns information extraction and prioritization rules

   Log: extraction, sections, feedback
   Output: section priorities, compression profiles
   Use when: Extracting relevant content from source material

   Example: Extracting key findings from research papers

Which learner would you like to learn more about? (1-4 or 'back'): _
```

## 2. Quick Start

```bash
Select: 2

Quick Start - Choose Your Learner:

1. Decision Historian
2. Style Learner
3. Meta-Recipe Tuner
4. Knowledge Compressor

Select (1-4): 2

╔════════════════════════════════════════════════════════════════╗
║                   STYLE LEARNER QUICK START                    ║
╚════════════════════════════════════════════════════════════════╝

Step 1: Log an execution
  /learner-log
  > Select: Style Learner
  > Input prompt: "Professional email to client"
  > Output: "I am writing to inform you..."

Step 2: Log edits (user feedback)
  Include edits like:
  - Original: "I am"
  - Replacement: "I'm"
  - Reason: "more conversational"

Step 3: Repeat steps 1-2 several times
  Need minimum 3 executions with 5+ edits

Step 4: Analyze patterns
  /learner-analyze
  > Select: Style Learner

  See: formality score, perspective, confidence

Step 5: Use recommendations
  Your recipe can now use learned style preferences!

Ready to start?
  /learner-log
```

## 3. Available Commands

```bash
Select: 3

╔════════════════════════════════════════════════════════════════╗
║                    AVAILABLE COMMANDS                          ║
╚════════════════════════════════════════════════════════════════╝

CORE COMMANDS:
  /learner-log      - Log execution or feedback data
  /learner-analyze  - Analyze patterns from data
  /learner-status   - Check status of all learners
  /learner-clear    - Clear learner data (reset)
  /learner-export   - Export data (JSON, CSV, Markdown)
  /learner-guide    - This guide

USAGE PATTERNS:

Basic Workflow:
  1. /learner-log (add data)
  2. /learner-log (add feedback)
  3. /learner-analyze (see patterns)

Monitoring:
  1. /learner-status (check progress)
  2. /learner-export (backup data)

Maintenance:
  1. /learner-export (backup first!)
  2. /learner-clear (reset if needed)

Each command has interactive prompts - just follow along!
```

## 4. Example Workflows

```bash
Select: 4

╔════════════════════════════════════════════════════════════════╗
║                    EXAMPLE WORKFLOWS                           ║
╚════════════════════════════════════════════════════════════════╝

WORKFLOW 1: Learn Personal Email Style
─────────────────────────────────────────

Step 1: Generate 5 emails with /learner-log
  For each: log generation + user edits

Step 2: Analyze with /learner-analyze
  Learn: formality=0.45, uses first-person, casual tone

Step 3: Use in recipe
  Generate emails matching learned style

Step 4: Keep improving
  Log more emails, analyze updates, recipes get better


WORKFLOW 2: Optimize Blog Writing Pipeline
──────────────────────────────────────────

Step 1: Run blog writer 5+ times with /learner-log
  Log: research time, drafting time, quality scores

Step 2: Analyze with /learner-analyze
  Learn: research stage is bottleneck (12s avg)

Step 3: Optimize
  Could use pre-cached research or parallel drafting

Step 4: Measure improvement
  Log new runs, see if bottleneck improved


WORKFLOW 3: Extract Better Research Papers
──────────────────────────────────────────

Step 1: Extract 5+ papers with /learner-log
  Log: sections found + what user kept/removed

Step 2: Analyze with /learner-analyze
  Learn: abstract always kept, methods rarely used

Step 3: Smart extraction
  Always include abstract, skip methods by default

Step 4: Refine
  Log more papers, update priorities


Which workflow interests you? (1-3 or 'back'): _
```

## 5. Troubleshooting

```bash
Select: 5

Common Issues:

Q: "Need more data" when running /learner-analyze
A: Minimum samples required:
   - Decision Historian: 3 samples
   - Style Learner: 3 samples, 5+ edits
   - Meta-Recipe Tuner: 5 samples
   - Knowledge Compressor: 5 samples

   Solution: /learner-log more data, then retry

Q: Low confidence scores
A: Confidence scales from 0-1:
   < 0.3: unreliable, need more data
   0.3-0.7: moderate, validate recommendations
   > 0.7: high confidence, trust the patterns

   Solution: Log more varied executions

Q: Data won't delete with /learner-clear
A: Might be permission issue or .data/ folder locked
   Solution: Check .data/ folder permissions

Q: Want to reset everything
A: /learner-clear all

Need more help?
  See: /learner-guide > Full documentation
```

## 6. Full Documentation

```bash
Select: 6

Full Documentation Links:

📖 LEARNER_TOOLS_GUIDE.md
   Complete reference for all 4 learners
   Integration patterns, best practices, API reference

   Read: docs/LEARNER_TOOLS_GUIDE.md

📋 LEARNER_QUICK_REFERENCE.md
   Quick lookup tables and common patterns
   Error messages, debugging tips

   Read: docs/LEARNER_QUICK_REFERENCE.md

💻 learner_integration_example.py
   Working code showing all 4 learners together
   Real-world blog writing scenario

   Run: python -m examples.learner_integration_example

API Reference:
  - Decision Historian: log_execution(), log_feedback()
  - Style Learner: log_execution(), log_edits()
  - Meta-Recipe Tuner: log_stage()
  - Knowledge Compressor: log_extraction(), log_feedback()

All learners: learn(), get_recommendations()
```

## Navigation

From any menu:
- Type number (1-6) to select
- Type 'back' to return to main menu
- Type 'exit' to quit guide
- Type 'help' for detailed command help

## Quick Command Reference

```
/learner-log       → Add data
/learner-analyze   → See patterns
/learner-status    → Check progress
/learner-export    → Backup data
/learner-clear     → Reset learner
/learner-guide     → This guide
```

Start here:
  1. `/learner-guide` (you are here!)
  2. `/learner-log` (add your first data point)
  3. `/learner-status` (see what you have)
  4. `/learner-analyze` (discover patterns)

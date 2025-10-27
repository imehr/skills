# Learner Tools Skill - Quick Reference

## Installation

```bash
/skill learner-tools
```

Or manually:
```bash
from amplifier.learning.decision_historian import DecisionHistorian
from amplifier.learning.style_learner import StyleLearner
from amplifier.learning.meta_recipe_tuner import MetaRecipeTuner
from amplifier.learning.knowledge_compressor import KnowledgeCompressor
```

## Quick Start (30 seconds)

### 1. Decision Historian - Learn Better Decisions

```python
from amplifier.learning.decision_historian import DecisionHistorian

dh = DecisionHistorian()

# Log 3+ decisions with context and outcomes
dh.log_execution(
    execution_id="decision_001",
    context={"difficulty": "hard"},
    decision={"approach": "detailed"},
    outcome={"success": 0.95}
)

# Learn patterns
dh.learn()

# Get recommendations
recs = dh.get_recommendations()
```

### 2. Style Learner - Learn Personal Voice

```python
from amplifier.learning.style_learner import StyleLearner

sl = StyleLearner()

# Log 3+ generations with edits
sl.log_execution(
    execution_id="email_001",
    input_prompt="Professional email",
    generated_output="I am writing..."
)

sl.log_edits(
    execution_id="email_001",
    edits=[{"original": "I am", "replacement": "I'm", "reason": "casual"}]
)

# Learn style
sl.learn()

# Get profile
recs = sl.get_recommendations()
# Result: {"formality": 0.45, "perspective": "first"}
```

### 3. Meta-Recipe Tuner - Optimize Performance

```python
from amplifier.learning.meta_recipe_tuner import MetaRecipeTuner

mrt = MetaRecipeTuner()

# Log 5+ stage runs
mrt.log_stage(
    recipe_id="blog_writer",
    run_id="run_001",
    stage_name="research",
    duration_sec=12.5,
    quality_metric=0.92
)

# Learn performance
mrt.learn()

# Get bottleneck
recs = mrt.get_recommendations()
# Result: {"bottleneck_stage": "research"}
```

### 4. Knowledge Compressor - Extract Better Content

```python
from amplifier.learning.knowledge_compressor import KnowledgeCompressor

kc = KnowledgeCompressor()

# Log 5+ extractions
kc.log_extraction(
    extraction_id="extract_001",
    source_type="paper",
    input_tokens=2500,
    sections=[
        {"name": "abstract", "tokens": 200},
        {"name": "results", "tokens": 1000}
    ]
)

kc.log_feedback(
    extraction_id="extract_001",
    kept_sections=["abstract", "results"],
    removed_sections=["methods"],
    reason="Focus on findings"
)

# Learn extraction
kc.learn()

# Get priorities
recs = kc.get_recommendations()
# Result: {"section_priorities": {"abstract": 0.95}}
```

## CLI Commands

```bash
/learner-guide      # Interactive tutorial
/learner-log        # Log execution or feedback
/learner-analyze    # Analyze patterns
/learner-status     # Check status
/learner-clear      # Reset data
/learner-export     # Backup/export
```

## Data Requirements

| Learner | Samples | Feedback |
|---------|---------|----------|
| Decision Historian | 3 | 2 contexts |
| Style Learner | 3 | 5 edits |
| Meta-Recipe Tuner | 5 | 2 stages |
| Knowledge Compressor | 5 | 3 sections |

## Common Patterns

### Multi-Learner Integration

```python
class SelfImprovingRecipe:
    def __init__(self):
        self.dh = DecisionHistorian()
        self.sl = StyleLearner()
        self.mrt = MetaRecipeTuner()
        self.kc = KnowledgeCompressor()

    def execute(self, data):
        # Log decision, style, performance
        self.dh.log_execution(...)
        self.sl.log_execution(...)
        self.mrt.log_stage(...)

        return output

    def improve(self):
        # Learn from all
        self.dh.learn()
        self.sl.learn()
        self.mrt.learn()
        self.kc.learn()
```

### Confidence Checking

```python
recs = learner.get_recommendations()

if recs.get("confidence", 0) > 0.7:
    # Recommendations are reliable
    apply_recommendations(recs)
else:
    # Need more data
    log_more_data()
```

## Troubleshooting

**"Need more data"**
- Learners have minimum sample requirements
- Log more executions and try again

**"Confidence too low"**
- Confidence < 0.7 means unreliable
- Log more varied data to improve confidence

**"No patterns found"**
- Not enough variation in feedback
- Try different approaches and log all

## Best Practices

1. **Log immediately** - Don't batch executions
2. **Provide context** - Detailed feedback helps learning
3. **Use meaningful IDs** - `execution_id="email_2024_10_25_001"`
4. **Check confidence** - Only use recs with confidence > 0.7
5. **Regular learning** - Run learn() every 5-10 executions
6. **Backup data** - Use export for important learnings

## Storage

All data stored in:
```
.data/learning/
├── decision_historian/
├── style_learner/
├── meta_recipe_tuner/
└── knowledge_compressor/
```

Each contains: `executions.jsonl`, `feedback.jsonl`, `recommendations.json`

## Features

✅ Self-improving recipes
✅ Pattern extraction
✅ Confidence scoring
✅ Cloud-sync safe
✅ 100% type hints
✅ 44 tests passing

## Links

- **Full Guide**: See `docs/LEARNER_TOOLS_GUIDE.md`
- **Examples**: `examples/learner_integration_example.py`
- **Marketplace**: https://github.com/imehr/imehr-marketplace
- **Repository**: https://github.com/imehr/amplifier

## Version

- **Skill Version**: 1.0.0
- **Status**: Production Ready
- **License**: MIT
- **Last Updated**: 2024-10-27

---

**Ready to use! Start with `/learner-guide` for interactive help.**

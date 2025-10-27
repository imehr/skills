"""
Decision Historian Example - Learning Context-Aware Decisions

This example demonstrates how to use the Decision Historian learner to:
1. Log decisions made in different contexts
2. Track outcomes for each decision
3. Extract patterns about which decisions work best
4. Get recommendations for future decisions
"""

from amplifier.learning.decision_historian import DecisionHistorian


def example_task_planning():
    """Example: Learning optimal task planning strategies."""
    print("=" * 70)
    print("EXAMPLE 1: Learning Task Planning Strategies")
    print("=" * 70)

    dh = DecisionHistorian()

    # Simulate multiple executions with different planning strategies
    contexts = [
        {"difficulty": "easy", "time_available": 60, "team_size": 1},
        {"difficulty": "easy", "time_available": 60, "team_size": 1},
        {"difficulty": "easy", "time_available": 60, "team_size": 1},
        {"difficulty": "hard", "time_available": 30, "team_size": 3},
        {"difficulty": "hard", "time_available": 30, "team_size": 3},
        {"difficulty": "hard", "time_available": 30, "team_size": 3},
    ]

    decisions = [
        {"approach": "quick_sketch"},  # Works well for easy tasks
        {"approach": "quick_sketch"},
        {"approach": "quick_sketch"},
        {"approach": "detailed_planning"},  # Works well for hard tasks
        {"approach": "detailed_planning"},
        {"approach": "detailed_planning"},
    ]

    outcomes = [
        {"success": 0.95, "time_used": 45},
        {"success": 0.92, "time_used": 40},
        {"success": 0.94, "time_used": 50},
        {"success": 0.88, "time_used": 32},
        {"success": 0.90, "time_used": 30},
        {"success": 0.87, "time_used": 35},
    ]

    # Log all executions
    for i, (context, decision, outcome) in enumerate(zip(contexts, decisions, outcomes, strict=False)):
        dh.log_execution(
            execution_id=f"task_{i:03d}",
            context=context,
            decision=decision,
            outcome=outcome,
        )
        print(
            f"✓ Logged task_{i:03d}: {context['difficulty']} task, "
            f"approach={decision['approach']}, success={outcome['success']}"
        )

    print("\n" + "-" * 70)
    print("Running learning phase...")
    print("-" * 70 + "\n")

    # Learn patterns
    result = dh.learn()

    print(f"Patterns found: {result['patterns_found']}")
    print(f"Timestamp: {result['timestamp']}")

    # Get recommendations
    recommendations = dh.get_recommendations()

    print("\n" + "=" * 70)
    print("RECOMMENDATIONS BY CONTEXT")
    print("=" * 70)

    for context_key, scores in recommendations.items():
        print(f"\n{context_key}:")
        for approach, confidence in scores.items():
            confidence_pct = confidence * 100
            print(f"  {approach}: {confidence_pct:.0f}% confidence")

    print("\n" + "=" * 70)
    print("INSIGHTS")
    print("=" * 70)
    print("""
The Decision Historian discovered:
1. For EASY tasks: Quick sketching is highly successful (92-95%)
2. For HARD tasks: Detailed planning is more successful (87-90%)
3. Context matters: The same decision in different contexts yields different results

This is powerful because it shows HOW to make BETTER decisions based on CONTEXT!
    """)


def example_debugging_strategy():
    """Example: Learning optimal debugging strategies."""
    print("\n" + "=" * 70)
    print("EXAMPLE 2: Learning Debugging Strategies")
    print("=" * 70)

    dh = DecisionHistorian()

    # Log different debugging strategies in different bug scenarios
    scenarios = [
        {"bug_type": "logic_error", "code_complexity": "simple"},
        {"bug_type": "logic_error", "code_complexity": "simple"},
        {"bug_type": "logic_error", "code_complexity": "simple"},
        {"bug_type": "race_condition", "code_complexity": "complex"},
        {"bug_type": "race_condition", "code_complexity": "complex"},
        {"bug_type": "race_condition", "code_complexity": "complex"},
    ]

    strategies = [
        {"approach": "print_statements"},  # Works for simple bugs
        {"approach": "print_statements"},
        {"approach": "print_statements"},
        {"approach": "instrumentation"},  # Works for race conditions
        {"approach": "instrumentation"},
        {"approach": "instrumentation"},
    ]

    results = [
        {"time_to_fix": 5, "success": True},
        {"time_to_fix": 7, "success": True},
        {"time_to_fix": 6, "success": True},
        {"time_to_fix": 45, "success": True},
        {"time_to_fix": 42, "success": True},
        {"time_to_fix": 48, "success": True},
    ]

    for i, (scenario, strategy, result) in enumerate(zip(scenarios, strategies, results, strict=False)):
        dh.log_execution(
            execution_id=f"debug_{i:03d}",
            context=scenario,
            decision=strategy,
            outcome=result,
        )

    dh.learn()
    recs = dh.get_recommendations()

    print("\nLearned patterns:")
    for context, strategies_scores in recs.items():
        print(f"\n{context}:")
        for strat, score in strategies_scores.items():
            print(f"  {strat}: {score * 100:.0f}%")


def example_api_request_routing():
    """Example: Learning optimal request routing strategies."""
    print("\n" + "=" * 70)
    print("EXAMPLE 3: Learning API Request Routing")
    print("=" * 70)

    dh = DecisionHistorian()

    # Learn which routing strategy works best for different load patterns
    for load in ["light", "light", "light", "heavy", "heavy", "heavy"]:
        execution_id = f"route_{load}_{dh.__dict__.get('_counter', 0)}"

        context = {"request_volume": "high" if load == "heavy" else "low"}
        decision = {"routing_strategy": "round_robin" if load == "light" else "least_loaded"}
        outcome = {
            "latency_ms": 50 if load == "light" else 120,
            "error_rate": 0.01 if load == "light" else 0.05,
        }

        dh.log_execution(
            execution_id=execution_id,
            context=context,
            decision=decision,
            outcome=outcome,
        )

    dh.learn()
    recommendations = dh.get_recommendations()

    print("\nAPI Routing Recommendations:")
    for context, strategies in recommendations.items():
        print(f"\n{context}:")
        for strategy, confidence in strategies.items():
            print(f"  {strategy}: {confidence * 100:.0f}% recommended")


if __name__ == "__main__":
    # Run all examples
    example_task_planning()
    example_debugging_strategy()
    example_api_request_routing()

    print("\n" + "=" * 70)
    print("✓ All Decision Historian examples completed!")
    print("=" * 70)

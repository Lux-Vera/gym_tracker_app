class WorkoutSet {
  final int reps;
  final int weight;

  WorkoutSet(this.reps, this.weight);

  Map<String, dynamic> toFirestore() {
    return {"reps": reps, "weight": weight};
  }
}

Bowler.destroy_all

juan  = Bowler.create(id: 1, name: 'Juan Dela Cruz', gender: 'M', bowling_association_id: 1, pbc_classification_id: BowlerClass.find_by_name('OPEN').id)
juan.average_entries.create(average: 200, user_id: 1)
def relevance_grade(row):
    if row['booking_bool'] == 1 and row['click_bool'] == 1:
        grade = 5
    elif row['click_bool'] == 0 and row['booking_bool'] == 0:
        grade = 0
    else: grade = 1
    return grade

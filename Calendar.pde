class Calendar {

    //Variables
    final String[] Months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int[] Days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    int startDay;
    int startMonth;
    int endDay;
    int endMonth;
    int totalDays = 0;
    float dAngle;
    ArrayList<String> CalendarMap = new ArrayList<String>();


    //Constructor
    Calendar(int _startDay, int _startMonth, int _endDay, int _endMonth) {
        startDay = _startDay;
        startMonth = _startMonth;
        endDay = _endDay;
        endMonth = _endMonth;
        int cur_startDay = startDay;
        int cur_endDay;

        //Get total days and split by 2PI
        for (int i = startMonth; i <= endMonth; i++) {

            // Get month end
            if  (i == endMonth) {
                cur_endDay = endDay;
            } else {
                cur_endDay = Days[i + 1];
            }
            for (int j = cur_startDay; j <= cur_endDay; j++) {
                totalDays++;
                // println("total: " + totalDays + ", month: ", Months[i-1] + ", day: " + j);
                CalendarMap.add( j + " " + Months[i-1]);
            }
            cur_startDay = 1;
        }

        //Set delta angle
        dAngle = TWO_PI / totalDays;
    }


    String getDate(float angle) {
        return CalendarMap.get(floor(angle / dAngle));
    }

}
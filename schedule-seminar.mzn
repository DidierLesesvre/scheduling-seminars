% Use COIN-BC  
% data3.dzn (m=7) runs in 814ms
% data4.dzn (m=10) runs in 3s
    
            % PARAMETERS
    
    int: n; % number of students
    set of int: STUDENTS=1..n; % students
    
    int: m; % number of topics
    set of int: PREFERENCE=1..m; % possible preference rankings
    set of int: TOPICS=1..m; % different topics
    set of int: RANK=1..m; % different topics
    
    int: maxseats; % number of seats available per course max
    int: minseats; % number of seats minimum per course
    
    array[STUDENTS,TOPICS] of PREFERENCE: preference; % ranking of topics by each student

% VARIABLES
    
    array[STUDENTS, TOPICS] of var bool: topicSelected;
    array[STUDENTS] of var TOPICS: course; 
    array[TOPICS] of var 0..n: number;

    constraint % channel number of students within each topic/timeslot
       forall(tt in TOPICS) (
          number[tt] = sum(ss in STUDENTS)(topicSelected[ss,tt]));
          
    constraint 
      forall(ss in STUDENTS, tt in TOPICS)(course[ss] = tt <-> topicSelected[ss,tt] = true);

    constraint % make sure there are enough students in a class but not too many
       forall(tt in TOPICS) (
          number[tt] > 0 -> number[tt] >= minseats /\ number[tt] <= maxseats);
     
    constraint % almost all the same number per topic
    forall(tt, ttt in TOPICS where tt<ttt)(abs(number[tt] - number[ttt]) <= 1);

    var int: satisfaction;
    constraint
       satisfaction = sum(ss in STUDENTS, tt in TOPICS)(topicSelected[ss,tt] * preference[ss,tt]^10);
    
    solve minimize satisfaction;

    output(["satisfaction: \(satisfaction)\n"]);
    output(["topics\t\tpreferences\n"]);
    output([" ", join(" ", [show([tt | tt in TOPICS where topicSelected[ss,tt]]) ++ "\t" ++
                            show([preference[ss,tt] | tt in TOPICS where topicSelected[ss,tt]]) ++
                            "\n" | ss in STUDENTS])]);
    output([show([number[tt] | tt in TOPICS])]); 
      output(["Number of choices worst than 3 =" ++ show(sum(ss in STUDENTS where preference[ss, course[ss]] > 4)(1)) ++ "\n"]); 
      output([show(sum(ss in STUDENTS where topicSelected[ss,tt])(preference[ss,tt]) / 20)  ++ "   " | tt in TOPICS]); 
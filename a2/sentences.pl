% Name: Jiahao Cheng, login_id: chengj60, student_id: 1003065737

% Part 1
% Grammar 1 & 2
% s_sg
test_sent([fred, feeds, the, dog, with, biscuits]).
test_sent([fred, feed, the, dog, with, biscuits], fails).

% s_pl
test_sent([biscuits, feed, the, dog, with, fred]).
test_sent([puppies, feeds, fred, with, the, dog], fails).

% vp & pp
test_sent([fred, feeds, puppies]).
test_sent([biscuits, feed, fred]).
test_sent([fred, feeds, the, dog, with, the, dog, with, biscuits], fails).
test_sent([fred, feeds, the, dog, biscuits], fails).
test_sent([fred, feeds, the, dog, with, feed], fails).

% np
test_sent([fred, feeds, the, dog, with, the, biscuits]).
test_sent([the, dog, feeds, the, fred, with, the, puppies], fails).
test_sent([the, dog, with, biscuits, feeds, the, dog], fails).

% Part 2
% tend
test_sent([the, student, tended, to, sleep]).
test_sent([the, student, tended, to, tend, to, sleep]).
test_sent([the, student, tended, the, teacher, to, sleep], fails).
test_sent([the, student, tended], fails).

% appear
test_sent([the, student, appeared, to, sleep]).
test_sent([the, teacher, appeared, to, tend, to, sleep]).
test_sent([the, teacher, appeared, the, teacher, to, sleep], fails).
test_sent([the, student, appeared], fails).

% promised
test_sent([the, student, promised, the, teacher, to, sleep]).
test_sent([the, student, promised, to, sleep], fails).
test_sent([the, student, promised, the, teacher, to, appear, to, sleep]).
test_sent([the, teacher, promised], fails).

% request
test_sent([the, student, requested, the, teacher, to, sleep]).
test_sent([the, student, requested, to, sleep], fails).
test_sent([the, student, requested, the, teacher, to, promise, to, sleep], fails).
test_sent([the, teacher, requested, the, teacher, to, promise, the, teacher, to, sleep]).
test_sent([the, teacher, requested], fails).

% sleep
test_sent([the, teacher, slept]).
test_sent([the, teacher, to, sleep], fails).
test_sent([the, student, slept, to, sleep], fails).
test_sent([the, teacher, slept, the, student], fails).

% s
test_sent([teacher, tended, to, sleep], fails).
test_sent([the, student, appeared, to, slept], fails).
test_sent([the, student, promised, teacher, to, sleep], fails).
test_sent([the, teacher, requested, the, teacher, sleep], fails).

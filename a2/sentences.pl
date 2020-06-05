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
test_sent([the, dog, with, biscuits, feeds, the, dog], fails)

% Part 2

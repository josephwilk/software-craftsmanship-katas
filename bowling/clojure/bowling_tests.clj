(ns bowling)
(use 'clojure.contrib.test-is)
(use 'bowling)

(deftest test-gutter-game
  (is (= 0 (score (repeat 20 0)))))

(run-tests)
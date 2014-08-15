(defn read-int [] (Integer/parseInt (read-line)))
(defn cubic [num] (* (* num num) num))
(println (cubic (read-int)))

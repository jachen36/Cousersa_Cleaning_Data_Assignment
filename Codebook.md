Codebook
===

Variable list and description
---

variable name | Description
---------------------------
subject_id    | The subject id number for the experiment. Range from 1 to 30
activity      | Activity name
domain        | Time or frequency
instrument    | Instrument used for measurement (Accelerometer or Gyroscope)
acceleration  | Acceleration signal (Body or Gravity)
variable      | Mean or Standard deviation
jerk          | True or False
magnitude     | True or False
axis          | X, Y, Z, NA

Getting DF
---
'''r
df <- run_analysis()
'''

Dataset structure
---

'''r
str(df)
'''

'''
'data.frame':	617940 obs. of  10 variables:
 $ subject_id  : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ activity    : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
 $ domain      : Factor w/ 2 levels "freq","time": 2 2 2 2 2 2 2 2 2 2 ...
 $ acceleration: Factor w/ 2 levels "Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
 $ instructment: Factor w/ 8 levels "Acc","AccJerk",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ variable    : Factor w/ 2 levels "mean","std": 1 1 1 1 1 1 1 1 1 1 ...
 $ axis        : Factor w/ 4 levels "NA","X","Y","Z": 2 2 2 2 2 2 2 2 2 2 ...
 $ jerk        : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
 $ mag         : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
 $ value       : num  0.289 0.278 0.28 0.279 0.277 ...
'''

List the key variables in the data frame
---

'''r
names(df)
'''

'''
 [1] "subject_id"   "activity"     "domain"       "acceleration"
 [5] "instructment" "variable"     "axis"         "jerk"        
 [9] "mag"          "value" 
'''

A few rows in the data frame
---
'''r
head(df)
'''

'''
  subject_id activity domain acceleration instructment variable axis
1          1 STANDING   time         Body          Acc     mean    X
2          1 STANDING   time         Body          Acc     mean    X
3          1 STANDING   time         Body          Acc     mean    X
4          1 STANDING   time         Body          Acc     mean    X
5          1 STANDING   time         Body          Acc     mean    X
6          1 STANDING   time         Body          Acc     mean    X
   jerk   mag     value
1 FALSE FALSE 0.2885845
2 FALSE FALSE 0.2784188
3 FALSE FALSE 0.2796531
4 FALSE FALSE 0.2791739
5 FALSE FALSE 0.2766288
6 FALSE FALSE 0.2771988
'''

Summary of the data frame
---
'''r
run_summarize(df)
'''

'''
Source: local data frame [6 x 3]
Groups: subject_id [1]

  subject_id           activity mean(value)
      (fctr)             (fctr)       (dbl)
1          1            WALKING  -0.1894951
2          1   WALKING_UPSTAIRS  -0.2999829
3          1 WALKING_DOWNSTAIRS  -0.1420307
4          1            SITTING  -0.7002721
5          1           STANDING  -0.7281147
6          1             LAYING  -0.6594628
'''


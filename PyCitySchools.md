
Analyze the district wide standardized test results. Aggregrate the data and showcase obvious trends in school performance. 

#### Observations

* Overall passing rate of the school ditrsict is 96%, Charter schools being the top performers with a 100% passing rate, 
  while some Districts schools are at the bottom with an overall passing rate of 94%.
* Schools with higher spending per student does not have better scores than schools with a lower budget per student.
  Infact, schools with lower budgets have the highest overall passing rate.
* Schools with lesser students (small school size) have a better overall passing rate.
* Overall performance is better in Reading as compared to Math 



```python
import pandas as pd
import os
```


```python
school_path = os.path.join("raw_data", "schools_complete.csv")
student_path = os.path.join("raw_data", "students_complete.csv")
```


```python
school_df = pd.read_csv(school_path)
student_df = pd.read_csv(student_path)
```


```python
# Asssuming passing grade is greater than 59
passing_math_df = student_df.loc[student_df["math_score"] > 59, :]
passing_reading_df = student_df.loc[student_df["reading_score"] > 59, :]
total_passing_math = len(passing_math_df)
total_passing_reading = len(passing_reading_df)

```


```python
total_schools = len(school_df)
total_students = len(student_df)
total_budget = sum(school_df["budget"])
avg_math_score = student_df["math_score"].mean()
avg_reading_score = student_df["reading_score"].mean()
percent_passing_math = total_passing_math/total_students * 100
percent_passing_reading = total_passing_reading/total_students * 100
overall_pass_rate = (percent_passing_math + percent_passing_reading)/2
```


```python
district_summary_df = pd.DataFrame({"Total Schools" : [total_schools], 
                                  "Total Students" : [total_students], 
                                  "Total Budget" : [total_budget], 
                                  "Average Math Score" : [avg_math_score], 
                                  "Average Reading Score" : [avg_reading_score], 
                                  "% Passing Math" : [percent_passing_math], 
                                  "% Passing Reading" : [percent_passing_reading], 
                                  "Overall Passing rate" : [overall_pass_rate]
                                 }
                                )
district_summary_df = district_summary_df[["Total Schools", "Total Students", "Total Budget", "Average Math Score", 
                                            "Average Reading Score", "% Passing Math", "% Passing Reading", 
                                            "Overall Passing rate"]]
print("District Summary")
district_summary_df
```

    District Summary
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Total Schools</th>
      <th>Total Students</th>
      <th>Total Budget</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>Overall Passing rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>15</td>
      <td>39170</td>
      <td>24649428</td>
      <td>78.985371</td>
      <td>81.87784</td>
      <td>92.445749</td>
      <td>100.0</td>
      <td>96.222875</td>
    </tr>
  </tbody>
</table>
</div>




```python
school_df["per student budget"] = school_df["budget"]/school_df["size"]

math_avg_per_school = student_df.groupby("school")["math_score"].mean()

reading_avg_per_school = student_df.groupby("school")["reading_score"].mean()

group_school = student_df.groupby("school")["school"].count()

math_passing_per_school = passing_math_df.groupby("school")["school"].count()
math_percent_passing_per_school = math_passing_per_school/group_school * 100

reading_passing_per_school = passing_reading_df.groupby("school")["school"].count()
reading_percent_passing_per_school = reading_passing_per_school/group_school * 100

overall_passing_rate = (math_percent_passing_per_school + reading_percent_passing_per_school) / 2
```


```python
school_metrics_df = pd.DataFrame({
                                  "average math score": math_avg_per_school,
                                  "average reading score": reading_avg_per_school, 
                                  "% passing math": math_percent_passing_per_school, 
                                  "% passing reading": reading_percent_passing_per_school,
                                  "overall passing rate": overall_passing_rate
                                 } 
                                )
school_metrics_df = school_metrics_df[["average math score","average reading score","% passing math",
                                       "% passing reading","overall passing rate"]]
```


```python
school_metrics_df = school_metrics_df.reset_index()
school_metrics_df = school_metrics_df.rename(columns={"school":"name"})
school_summary_df = pd.merge(school_df.iloc[:, [1,2,3,4,5]], school_metrics_df, on ="name")

```


```python
school_summary_df = school_summary_df.rename(columns={"name": "school name", "type": "school type", "size": "total students", 
                                                      "budget": "total school budget"})

print("School Summary")
school_summary_df                                                            
```

    School Summary
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>school name</th>
      <th>school type</th>
      <th>total students</th>
      <th>total school budget</th>
      <th>per student budget</th>
      <th>average math score</th>
      <th>average reading score</th>
      <th>% passing math</th>
      <th>% passing reading</th>
      <th>overall passing rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Huang High School</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
      <td>655.0</td>
      <td>76.629414</td>
      <td>81.182722</td>
      <td>88.858416</td>
      <td>100.0</td>
      <td>94.429208</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Figueroa High School</td>
      <td>District</td>
      <td>2949</td>
      <td>1884411</td>
      <td>639.0</td>
      <td>76.711767</td>
      <td>81.158020</td>
      <td>88.436758</td>
      <td>100.0</td>
      <td>94.218379</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Shelton High School</td>
      <td>Charter</td>
      <td>1761</td>
      <td>1056600</td>
      <td>600.0</td>
      <td>83.359455</td>
      <td>83.725724</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Hernandez High School</td>
      <td>District</td>
      <td>4635</td>
      <td>3022020</td>
      <td>652.0</td>
      <td>77.289752</td>
      <td>80.934412</td>
      <td>89.083064</td>
      <td>100.0</td>
      <td>94.541532</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Griffin High School</td>
      <td>Charter</td>
      <td>1468</td>
      <td>917500</td>
      <td>625.0</td>
      <td>83.351499</td>
      <td>83.816757</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Wilson High School</td>
      <td>Charter</td>
      <td>2283</td>
      <td>1319574</td>
      <td>578.0</td>
      <td>83.274201</td>
      <td>83.989488</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Cabrera High School</td>
      <td>Charter</td>
      <td>1858</td>
      <td>1081356</td>
      <td>582.0</td>
      <td>83.061895</td>
      <td>83.975780</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>7</th>
      <td>Bailey High School</td>
      <td>District</td>
      <td>4976</td>
      <td>3124928</td>
      <td>628.0</td>
      <td>77.048432</td>
      <td>81.033963</td>
      <td>89.529743</td>
      <td>100.0</td>
      <td>94.764871</td>
    </tr>
    <tr>
      <th>8</th>
      <td>Holden High School</td>
      <td>Charter</td>
      <td>427</td>
      <td>248087</td>
      <td>581.0</td>
      <td>83.803279</td>
      <td>83.814988</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>9</th>
      <td>Pena High School</td>
      <td>Charter</td>
      <td>962</td>
      <td>585858</td>
      <td>609.0</td>
      <td>83.839917</td>
      <td>84.044699</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>10</th>
      <td>Wright High School</td>
      <td>Charter</td>
      <td>1800</td>
      <td>1049400</td>
      <td>583.0</td>
      <td>83.682222</td>
      <td>83.955000</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>11</th>
      <td>Rodriguez High School</td>
      <td>District</td>
      <td>3999</td>
      <td>2547363</td>
      <td>637.0</td>
      <td>76.842711</td>
      <td>80.744686</td>
      <td>88.547137</td>
      <td>100.0</td>
      <td>94.273568</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Johnson High School</td>
      <td>District</td>
      <td>4761</td>
      <td>3094650</td>
      <td>650.0</td>
      <td>77.072464</td>
      <td>80.966394</td>
      <td>89.182945</td>
      <td>100.0</td>
      <td>94.591472</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Ford High School</td>
      <td>District</td>
      <td>2739</td>
      <td>1763916</td>
      <td>644.0</td>
      <td>77.102592</td>
      <td>80.746258</td>
      <td>89.302665</td>
      <td>100.0</td>
      <td>94.651333</td>
    </tr>
    <tr>
      <th>14</th>
      <td>Thomas High School</td>
      <td>Charter</td>
      <td>1635</td>
      <td>1043130</td>
      <td>638.0</td>
      <td>83.418349</td>
      <td>83.848930</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
  </tbody>
</table>
</div>




```python
top_performers_df = school_summary_df.sort_values(["overall passing rate"], ascending = False)
top_performers_df = top_performers_df.iloc[0:5,:]
top_performers_df = top_performers_df.set_index("school name")
print("Top Performing Schools (By Passing Rate)")
top_performers_df
```

    Top Performing Schools (By Passing Rate)
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>school type</th>
      <th>total students</th>
      <th>total school budget</th>
      <th>per student budget</th>
      <th>average math score</th>
      <th>average reading score</th>
      <th>% passing math</th>
      <th>% passing reading</th>
      <th>overall passing rate</th>
    </tr>
    <tr>
      <th>school name</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Shelton High School</th>
      <td>Charter</td>
      <td>1761</td>
      <td>1056600</td>
      <td>600.0</td>
      <td>83.359455</td>
      <td>83.725724</td>
      <td>100.0</td>
      <td>100.0</td>
      <td>100.0</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>Charter</td>
      <td>1468</td>
      <td>917500</td>
      <td>625.0</td>
      <td>83.351499</td>
      <td>83.816757</td>
      <td>100.0</td>
      <td>100.0</td>
      <td>100.0</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>Charter</td>
      <td>2283</td>
      <td>1319574</td>
      <td>578.0</td>
      <td>83.274201</td>
      <td>83.989488</td>
      <td>100.0</td>
      <td>100.0</td>
      <td>100.0</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>Charter</td>
      <td>1858</td>
      <td>1081356</td>
      <td>582.0</td>
      <td>83.061895</td>
      <td>83.975780</td>
      <td>100.0</td>
      <td>100.0</td>
      <td>100.0</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>Charter</td>
      <td>427</td>
      <td>248087</td>
      <td>581.0</td>
      <td>83.803279</td>
      <td>83.814988</td>
      <td>100.0</td>
      <td>100.0</td>
      <td>100.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
bottom_performers_df = school_summary_df.sort_values(["overall passing rate"])
bottom_performers_df = bottom_performers_df.iloc[0:5, :]
bottom_performers_df = bottom_performers_df.set_index("school name")
print("Bottom Performing Schools (By Passing Rate)")
bottom_performers_df
```

    Bottom Performing Schools (By Passing Rate)
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>school type</th>
      <th>total students</th>
      <th>total school budget</th>
      <th>per student budget</th>
      <th>average math score</th>
      <th>average reading score</th>
      <th>% passing math</th>
      <th>% passing reading</th>
      <th>overall passing rate</th>
    </tr>
    <tr>
      <th>school name</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Figueroa High School</th>
      <td>District</td>
      <td>2949</td>
      <td>1884411</td>
      <td>639.0</td>
      <td>76.711767</td>
      <td>81.158020</td>
      <td>88.436758</td>
      <td>100.0</td>
      <td>94.218379</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>District</td>
      <td>3999</td>
      <td>2547363</td>
      <td>637.0</td>
      <td>76.842711</td>
      <td>80.744686</td>
      <td>88.547137</td>
      <td>100.0</td>
      <td>94.273568</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
      <td>655.0</td>
      <td>76.629414</td>
      <td>81.182722</td>
      <td>88.858416</td>
      <td>100.0</td>
      <td>94.429208</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>District</td>
      <td>4635</td>
      <td>3022020</td>
      <td>652.0</td>
      <td>77.289752</td>
      <td>80.934412</td>
      <td>89.083064</td>
      <td>100.0</td>
      <td>94.541532</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>District</td>
      <td>4761</td>
      <td>3094650</td>
      <td>650.0</td>
      <td>77.072464</td>
      <td>80.966394</td>
      <td>89.182945</td>
      <td>100.0</td>
      <td>94.591472</td>
    </tr>
  </tbody>
</table>
</div>




```python
math_avg_per_grade = student_df.groupby(['school', 'grade'])['math_score'].mean().unstack() 
math_avg_per_grade = math_avg_per_grade[["9th", "10th", "11th", "12th"]]
print("Math Scores by Grade")
math_avg_per_grade
```

    Math Scores by Grade
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>grade</th>
      <th>9th</th>
      <th>10th</th>
      <th>11th</th>
      <th>12th</th>
    </tr>
    <tr>
      <th>school</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>77.083676</td>
      <td>76.996772</td>
      <td>77.515588</td>
      <td>76.492218</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>83.094697</td>
      <td>83.154506</td>
      <td>82.765560</td>
      <td>83.277487</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>76.403037</td>
      <td>76.539974</td>
      <td>76.884344</td>
      <td>77.151369</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>77.361345</td>
      <td>77.672316</td>
      <td>76.918058</td>
      <td>76.179963</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>82.044010</td>
      <td>84.229064</td>
      <td>83.842105</td>
      <td>83.356164</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>77.438495</td>
      <td>77.337408</td>
      <td>77.136029</td>
      <td>77.186567</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>83.787402</td>
      <td>83.429825</td>
      <td>85.000000</td>
      <td>82.855422</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>77.027251</td>
      <td>75.908735</td>
      <td>76.446602</td>
      <td>77.225641</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>77.187857</td>
      <td>76.691117</td>
      <td>77.491653</td>
      <td>76.863248</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>83.625455</td>
      <td>83.372000</td>
      <td>84.328125</td>
      <td>84.121547</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>76.859966</td>
      <td>76.612500</td>
      <td>76.395626</td>
      <td>77.690748</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>83.420755</td>
      <td>82.917411</td>
      <td>83.383495</td>
      <td>83.778976</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>83.590022</td>
      <td>83.087886</td>
      <td>83.498795</td>
      <td>83.497041</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>83.085578</td>
      <td>83.724422</td>
      <td>83.195326</td>
      <td>83.035794</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>83.264706</td>
      <td>84.010288</td>
      <td>83.836782</td>
      <td>83.644986</td>
    </tr>
  </tbody>
</table>
</div>




```python
reading_avg_per_grade = student_df.groupby(['school', 'grade'])['reading_score'].mean().unstack()
print("Reading Scores by Grade")
reading_avg_per_grade[["9th","10th", "11th", "12th"]]
#reading_avg_per_grade.sort_index(axis =0,ascending = True)
```

    Reading Scores by Grade
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>grade</th>
      <th>9th</th>
      <th>10th</th>
      <th>11th</th>
      <th>12th</th>
    </tr>
    <tr>
      <th>school</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>81.303155</td>
      <td>80.907183</td>
      <td>80.945643</td>
      <td>80.912451</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>83.676136</td>
      <td>84.253219</td>
      <td>83.788382</td>
      <td>84.287958</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>81.198598</td>
      <td>81.408912</td>
      <td>80.640339</td>
      <td>81.384863</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>80.632653</td>
      <td>81.262712</td>
      <td>80.403642</td>
      <td>80.662338</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>83.369193</td>
      <td>83.706897</td>
      <td>84.288089</td>
      <td>84.013699</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>80.866860</td>
      <td>80.660147</td>
      <td>81.396140</td>
      <td>80.857143</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>83.677165</td>
      <td>83.324561</td>
      <td>83.815534</td>
      <td>84.698795</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>81.290284</td>
      <td>81.512386</td>
      <td>81.417476</td>
      <td>80.305983</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>81.260714</td>
      <td>80.773431</td>
      <td>80.616027</td>
      <td>81.227564</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>83.807273</td>
      <td>83.612000</td>
      <td>84.335938</td>
      <td>84.591160</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>80.993127</td>
      <td>80.629808</td>
      <td>80.864811</td>
      <td>80.376426</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>84.122642</td>
      <td>83.441964</td>
      <td>84.373786</td>
      <td>82.781671</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>83.728850</td>
      <td>84.254157</td>
      <td>83.585542</td>
      <td>83.831361</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>83.939778</td>
      <td>84.021452</td>
      <td>83.764608</td>
      <td>84.317673</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>83.833333</td>
      <td>83.812757</td>
      <td>84.156322</td>
      <td>84.073171</td>
    </tr>
  </tbody>
</table>
</div>




```python
scores_by_spending_df = school_summary_df.loc[:, ["average math score","average reading score","% passing math",
                                                  "% passing reading","overall passing rate","per student budget"]]
bins = [575, 600, 625, 650, 675]
group_names =["<600", "600-625", "625-650", "650-675"]
scores_by_spending_df["spending ranges(per student)"] = pd.cut(scores_by_spending_df["per student budget"], bins, labels=group_names)
group_scores_by_spending = scores_by_spending_df.groupby("spending ranges(per student)")
del scores_by_spending_df['per student budget']
print("Scores by School Spending")
group_scores_by_spending.mean()
```

    Scores by School Spending
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>average math score</th>
      <th>average reading score</th>
      <th>% passing math</th>
      <th>% passing reading</th>
      <th>overall passing rate</th>
    </tr>
    <tr>
      <th>spending ranges(per student)</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>&lt;600</th>
      <td>83.436210</td>
      <td>83.892196</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>600-625</th>
      <td>83.595708</td>
      <td>83.930728</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>625-650</th>
      <td>78.032719</td>
      <td>81.416375</td>
      <td>90.833208</td>
      <td>100.0</td>
      <td>95.416604</td>
    </tr>
    <tr>
      <th>650-675</th>
      <td>76.959583</td>
      <td>81.058567</td>
      <td>88.970740</td>
      <td>100.0</td>
      <td>94.485370</td>
    </tr>
  </tbody>
</table>
</div>




```python
scores_by_size_df = school_summary_df.loc[:, ["average math score","average reading score","% passing math",
                                                  "% passing reading","overall passing rate","total students"]]
bins= [0, 1000, 3000, 5000]
group_names = ["Small", "Medium", "Large"]
scores_by_size_df["school size"] = pd.cut(scores_by_size_df["total students"], bins, labels=group_names)
group_scores_by_size = scores_by_size_df.groupby("school size")
del scores_by_size_df['total students']
print("Scores by School Size")
group_scores_by_size.mean()
```

    Scores by School Size
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>average math score</th>
      <th>average reading score</th>
      <th>% passing math</th>
      <th>% passing reading</th>
      <th>overall passing rate</th>
    </tr>
    <tr>
      <th>school size</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Small</th>
      <td>83.821598</td>
      <td>83.929843</td>
      <td>100.000000</td>
      <td>100.0</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>Medium</th>
      <td>81.176821</td>
      <td>82.933187</td>
      <td>96.288649</td>
      <td>100.0</td>
      <td>98.144324</td>
    </tr>
    <tr>
      <th>Large</th>
      <td>77.063340</td>
      <td>80.919864</td>
      <td>89.085722</td>
      <td>100.0</td>
      <td>94.542861</td>
    </tr>
  </tbody>
</table>
</div>




```python
school_type_group1 = school_summary_df.groupby("school type")["average math score"].mean()
school_type_group2 = school_summary_df.groupby("school type")["average reading score"].mean()
school_type_group3 = school_summary_df.groupby("school type")["% passing math"].mean()
school_type_group4 = school_summary_df.groupby("school type")["% passing reading"].mean()
school_type_group5 = school_summary_df.groupby("school type")["overall passing rate"].mean()

```


```python
scores_by_type_df = pd.DataFrame({"average math score": school_type_group1, 
                                  "average reading score": school_type_group2,
                                  "% passing math": school_type_group3,
                                  "% passing reading": school_type_group4,
                                   "overall passing rate": school_type_group5 })
print("Scores by School Type")
scores_by_type_df
```

    Scores by School Type
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>% passing math</th>
      <th>% passing reading</th>
      <th>average math score</th>
      <th>average reading score</th>
      <th>overall passing rate</th>
    </tr>
    <tr>
      <th>school type</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Charter</th>
      <td>100.000000</td>
      <td>100.0</td>
      <td>83.473852</td>
      <td>83.896421</td>
      <td>100.000000</td>
    </tr>
    <tr>
      <th>District</th>
      <td>88.991533</td>
      <td>100.0</td>
      <td>76.956733</td>
      <td>80.966636</td>
      <td>94.495766</td>
    </tr>
  </tbody>
</table>
</div>



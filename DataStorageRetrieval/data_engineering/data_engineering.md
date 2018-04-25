

```python
import os
import csv
import pandas as pd
```


```python
raw_measurements_path = os.path.join("Resources", "hawaii_measurements.csv")
raw_stations_path = os.path.join("Resources", "hawaii_stations.csv")
raw_measurements_df = pd.read_csv(raw_measurements_path, dtype=object)
raw_stations_df = pd.read_csv(raw_stations_path, dtype=object)
```


```python
raw_stations_df
```




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
      <th>station</th>
      <th>name</th>
      <th>latitude</th>
      <th>longitude</th>
      <th>elevation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>USC00519397</td>
      <td>WAIKIKI 717.2, HI US</td>
      <td>21.2716</td>
      <td>-157.8168</td>
      <td>3</td>
    </tr>
    <tr>
      <th>1</th>
      <td>USC00513117</td>
      <td>KANEOHE 838.1, HI US</td>
      <td>21.4234</td>
      <td>-157.8015</td>
      <td>14.6</td>
    </tr>
    <tr>
      <th>2</th>
      <td>USC00514830</td>
      <td>KUALOA RANCH HEADQUARTERS 886.9, HI US</td>
      <td>21.5213</td>
      <td>-157.8374</td>
      <td>7</td>
    </tr>
    <tr>
      <th>3</th>
      <td>USC00517948</td>
      <td>PEARL CITY, HI US</td>
      <td>21.3934</td>
      <td>-157.9751</td>
      <td>11.9</td>
    </tr>
    <tr>
      <th>4</th>
      <td>USC00518838</td>
      <td>UPPER WAHIAWA 874.3, HI US</td>
      <td>21.4992</td>
      <td>-158.0111</td>
      <td>306.6</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USC00519523</td>
      <td>WAIMANALO EXPERIMENTAL FARM, HI US</td>
      <td>21.33556</td>
      <td>-157.71139</td>
      <td>19.5</td>
    </tr>
    <tr>
      <th>6</th>
      <td>USC00519281</td>
      <td>WAIHEE 837.5, HI US</td>
      <td>21.45167</td>
      <td>-157.84889</td>
      <td>32.9</td>
    </tr>
    <tr>
      <th>7</th>
      <td>USC00511918</td>
      <td>HONOLULU OBSERVATORY 702.2, HI US</td>
      <td>21.3152</td>
      <td>-157.9992</td>
      <td>0.9</td>
    </tr>
    <tr>
      <th>8</th>
      <td>USC00516128</td>
      <td>MANOA LYON ARBO 785.2, HI US</td>
      <td>21.3331</td>
      <td>-157.8025</td>
      <td>152.4</td>
    </tr>
  </tbody>
</table>
</div>




```python
raw_measurements_df.head()
```




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
      <th>station</th>
      <th>date</th>
      <th>prcp</th>
      <th>tobs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>USC00519397</td>
      <td>2010-01-01</td>
      <td>0.08</td>
      <td>65</td>
    </tr>
    <tr>
      <th>1</th>
      <td>USC00519397</td>
      <td>2010-01-02</td>
      <td>0</td>
      <td>63</td>
    </tr>
    <tr>
      <th>2</th>
      <td>USC00519397</td>
      <td>2010-01-03</td>
      <td>0</td>
      <td>74</td>
    </tr>
    <tr>
      <th>3</th>
      <td>USC00519397</td>
      <td>2010-01-04</td>
      <td>0</td>
      <td>76</td>
    </tr>
    <tr>
      <th>4</th>
      <td>USC00519397</td>
      <td>2010-01-06</td>
      <td>NaN</td>
      <td>73</td>
    </tr>
  </tbody>
</table>
</div>




```python
raw_stations_df.isnull().any()
```




    station      False
    name         False
    latitude     False
    longitude    False
    elevation    False
    dtype: bool




```python
raw_measurements_df.isnull().any()
```




    station    False
    date       False
    prcp        True
    tobs       False
    dtype: bool




```python
raw_measurements_df.isnull().sum()
```




    station       0
    date          0
    prcp       1447
    tobs          0
    dtype: int64




```python
#measurements_df.fillna(0)
clean_measurements_df = raw_measurements_df.dropna(axis=0).reset_index(drop=True)
clean_measurements_df
```




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
      <th>station</th>
      <th>date</th>
      <th>prcp</th>
      <th>tobs</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>USC00519397</td>
      <td>2010-01-01</td>
      <td>0.08</td>
      <td>65</td>
    </tr>
    <tr>
      <th>1</th>
      <td>USC00519397</td>
      <td>2010-01-02</td>
      <td>0</td>
      <td>63</td>
    </tr>
    <tr>
      <th>2</th>
      <td>USC00519397</td>
      <td>2010-01-03</td>
      <td>0</td>
      <td>74</td>
    </tr>
    <tr>
      <th>3</th>
      <td>USC00519397</td>
      <td>2010-01-04</td>
      <td>0</td>
      <td>76</td>
    </tr>
    <tr>
      <th>4</th>
      <td>USC00519397</td>
      <td>2010-01-07</td>
      <td>0.06</td>
      <td>70</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USC00519397</td>
      <td>2010-01-08</td>
      <td>0</td>
      <td>64</td>
    </tr>
    <tr>
      <th>6</th>
      <td>USC00519397</td>
      <td>2010-01-09</td>
      <td>0</td>
      <td>68</td>
    </tr>
    <tr>
      <th>7</th>
      <td>USC00519397</td>
      <td>2010-01-10</td>
      <td>0</td>
      <td>73</td>
    </tr>
    <tr>
      <th>8</th>
      <td>USC00519397</td>
      <td>2010-01-11</td>
      <td>0.01</td>
      <td>64</td>
    </tr>
    <tr>
      <th>9</th>
      <td>USC00519397</td>
      <td>2010-01-12</td>
      <td>0</td>
      <td>61</td>
    </tr>
    <tr>
      <th>10</th>
      <td>USC00519397</td>
      <td>2010-01-14</td>
      <td>0</td>
      <td>66</td>
    </tr>
    <tr>
      <th>11</th>
      <td>USC00519397</td>
      <td>2010-01-15</td>
      <td>0</td>
      <td>65</td>
    </tr>
    <tr>
      <th>12</th>
      <td>USC00519397</td>
      <td>2010-01-16</td>
      <td>0</td>
      <td>68</td>
    </tr>
    <tr>
      <th>13</th>
      <td>USC00519397</td>
      <td>2010-01-17</td>
      <td>0</td>
      <td>64</td>
    </tr>
    <tr>
      <th>14</th>
      <td>USC00519397</td>
      <td>2010-01-18</td>
      <td>0</td>
      <td>72</td>
    </tr>
    <tr>
      <th>15</th>
      <td>USC00519397</td>
      <td>2010-01-19</td>
      <td>0</td>
      <td>66</td>
    </tr>
    <tr>
      <th>16</th>
      <td>USC00519397</td>
      <td>2010-01-20</td>
      <td>0</td>
      <td>66</td>
    </tr>
    <tr>
      <th>17</th>
      <td>USC00519397</td>
      <td>2010-01-21</td>
      <td>0</td>
      <td>69</td>
    </tr>
    <tr>
      <th>18</th>
      <td>USC00519397</td>
      <td>2010-01-22</td>
      <td>0</td>
      <td>67</td>
    </tr>
    <tr>
      <th>19</th>
      <td>USC00519397</td>
      <td>2010-01-23</td>
      <td>0</td>
      <td>67</td>
    </tr>
    <tr>
      <th>20</th>
      <td>USC00519397</td>
      <td>2010-01-24</td>
      <td>0.01</td>
      <td>71</td>
    </tr>
    <tr>
      <th>21</th>
      <td>USC00519397</td>
      <td>2010-01-25</td>
      <td>0</td>
      <td>67</td>
    </tr>
    <tr>
      <th>22</th>
      <td>USC00519397</td>
      <td>2010-01-26</td>
      <td>0.04</td>
      <td>76</td>
    </tr>
    <tr>
      <th>23</th>
      <td>USC00519397</td>
      <td>2010-01-27</td>
      <td>0.12</td>
      <td>68</td>
    </tr>
    <tr>
      <th>24</th>
      <td>USC00519397</td>
      <td>2010-01-28</td>
      <td>0</td>
      <td>72</td>
    </tr>
    <tr>
      <th>25</th>
      <td>USC00519397</td>
      <td>2010-01-31</td>
      <td>0.03</td>
      <td>67</td>
    </tr>
    <tr>
      <th>26</th>
      <td>USC00519397</td>
      <td>2010-02-01</td>
      <td>0.01</td>
      <td>66</td>
    </tr>
    <tr>
      <th>27</th>
      <td>USC00519397</td>
      <td>2010-02-04</td>
      <td>0.01</td>
      <td>69</td>
    </tr>
    <tr>
      <th>28</th>
      <td>USC00519397</td>
      <td>2010-02-05</td>
      <td>0</td>
      <td>67</td>
    </tr>
    <tr>
      <th>29</th>
      <td>USC00519397</td>
      <td>2010-02-06</td>
      <td>0</td>
      <td>67</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>18073</th>
      <td>USC00516128</td>
      <td>2017-07-17</td>
      <td>0.39</td>
      <td>72</td>
    </tr>
    <tr>
      <th>18074</th>
      <td>USC00516128</td>
      <td>2017-07-18</td>
      <td>2.4</td>
      <td>77</td>
    </tr>
    <tr>
      <th>18075</th>
      <td>USC00516128</td>
      <td>2017-07-19</td>
      <td>0.27</td>
      <td>74</td>
    </tr>
    <tr>
      <th>18076</th>
      <td>USC00516128</td>
      <td>2017-07-20</td>
      <td>0.7</td>
      <td>75</td>
    </tr>
    <tr>
      <th>18077</th>
      <td>USC00516128</td>
      <td>2017-07-21</td>
      <td>0.1</td>
      <td>72</td>
    </tr>
    <tr>
      <th>18078</th>
      <td>USC00516128</td>
      <td>2017-07-22</td>
      <td>4</td>
      <td>72</td>
    </tr>
    <tr>
      <th>18079</th>
      <td>USC00516128</td>
      <td>2017-07-23</td>
      <td>0.8</td>
      <td>78</td>
    </tr>
    <tr>
      <th>18080</th>
      <td>USC00516128</td>
      <td>2017-07-24</td>
      <td>0.84</td>
      <td>77</td>
    </tr>
    <tr>
      <th>18081</th>
      <td>USC00516128</td>
      <td>2017-07-25</td>
      <td>0.3</td>
      <td>79</td>
    </tr>
    <tr>
      <th>18082</th>
      <td>USC00516128</td>
      <td>2017-07-26</td>
      <td>0.3</td>
      <td>73</td>
    </tr>
    <tr>
      <th>18083</th>
      <td>USC00516128</td>
      <td>2017-07-27</td>
      <td>0</td>
      <td>75</td>
    </tr>
    <tr>
      <th>18084</th>
      <td>USC00516128</td>
      <td>2017-07-28</td>
      <td>0.4</td>
      <td>73</td>
    </tr>
    <tr>
      <th>18085</th>
      <td>USC00516128</td>
      <td>2017-07-29</td>
      <td>0.3</td>
      <td>77</td>
    </tr>
    <tr>
      <th>18086</th>
      <td>USC00516128</td>
      <td>2017-07-30</td>
      <td>0.3</td>
      <td>79</td>
    </tr>
    <tr>
      <th>18087</th>
      <td>USC00516128</td>
      <td>2017-07-31</td>
      <td>0</td>
      <td>74</td>
    </tr>
    <tr>
      <th>18088</th>
      <td>USC00516128</td>
      <td>2017-08-02</td>
      <td>0.25</td>
      <td>80</td>
    </tr>
    <tr>
      <th>18089</th>
      <td>USC00516128</td>
      <td>2017-08-03</td>
      <td>0.06</td>
      <td>76</td>
    </tr>
    <tr>
      <th>18090</th>
      <td>USC00516128</td>
      <td>2017-08-07</td>
      <td>0.05</td>
      <td>78</td>
    </tr>
    <tr>
      <th>18091</th>
      <td>USC00516128</td>
      <td>2017-08-08</td>
      <td>0.34</td>
      <td>74</td>
    </tr>
    <tr>
      <th>18092</th>
      <td>USC00516128</td>
      <td>2017-08-09</td>
      <td>0.15</td>
      <td>71</td>
    </tr>
    <tr>
      <th>18093</th>
      <td>USC00516128</td>
      <td>2017-08-10</td>
      <td>0.07</td>
      <td>75</td>
    </tr>
    <tr>
      <th>18094</th>
      <td>USC00516128</td>
      <td>2017-08-12</td>
      <td>0.14</td>
      <td>74</td>
    </tr>
    <tr>
      <th>18095</th>
      <td>USC00516128</td>
      <td>2017-08-14</td>
      <td>0.22</td>
      <td>79</td>
    </tr>
    <tr>
      <th>18096</th>
      <td>USC00516128</td>
      <td>2017-08-15</td>
      <td>0.42</td>
      <td>70</td>
    </tr>
    <tr>
      <th>18097</th>
      <td>USC00516128</td>
      <td>2017-08-16</td>
      <td>0.42</td>
      <td>71</td>
    </tr>
    <tr>
      <th>18098</th>
      <td>USC00516128</td>
      <td>2017-08-17</td>
      <td>0.13</td>
      <td>72</td>
    </tr>
    <tr>
      <th>18099</th>
      <td>USC00516128</td>
      <td>2017-08-19</td>
      <td>0.09</td>
      <td>71</td>
    </tr>
    <tr>
      <th>18100</th>
      <td>USC00516128</td>
      <td>2017-08-21</td>
      <td>0.56</td>
      <td>76</td>
    </tr>
    <tr>
      <th>18101</th>
      <td>USC00516128</td>
      <td>2017-08-22</td>
      <td>0.5</td>
      <td>76</td>
    </tr>
    <tr>
      <th>18102</th>
      <td>USC00516128</td>
      <td>2017-08-23</td>
      <td>0.45</td>
      <td>76</td>
    </tr>
  </tbody>
</table>
<p>18103 rows × 4 columns</p>
</div>




```python
clean_measurements_df.to_csv("Resources/clean_measurements.csv", index=False)
```


```python
raw_stations_df.to_csv("Resources/clean_stations.csv", index=False)
```

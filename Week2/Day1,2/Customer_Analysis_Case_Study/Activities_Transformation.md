# Activities List
Check the previous Done Activities in the [link](./Activities.md).

### Tasks 
Hint: use the file  ```Data_Marketing_Customer_Analysis_Round3.csv```
- check if there are highly correlated features and drop them if there are any.
- One Hot/Label Encoding of the categorical variables in the categoricals data frame that you created in Activity 3. ( Hint:  check Dropfirst option).
- for the first iteration, we will focus on the  numericals data (numericals data frame) as our data source.

**(Optional Task)**
by Peter Zimmerman

Begin by visually examining distributions (histagrams) of the numerical features. Select a variable, call it varA, which takes on a wide range of numerical values, and another, varB, which has noticably large skew (slanted with respect to the mean). For example, you might select customer_lifetime_value as a candidate varB which has skew.

1. varA
- Use minmax transform to bring varA's values into the range [0,1].
- Check that varA has been rescaled using a distplot or a histagram
2. varB
- Use StandardScalar or PowerTransform to reduce the skew and standardize varB's distribution.
- Check that the result has zero mean, unit variance, and reduced skew using mean(), std(), and a plot of the PDF.

Hints:

1. Import transformers from the sklearn library
```from sklearn.preprocessing import PowerTransformer, StandardScaler, minmax_scale```
- To reduce the skew and standardize a column, the PowerTransformer from sklearn has two options (box-cox and yeo-johnson). Try both and contrast the results.
- To rescale the column, use the minmax_scale transform.
2. Format the column correctly for the transformer.
The sklearn transformers expect numpy.ndarrary object types as input. To take a pandas column and transform it into the correct form for PowerTransform and minmax_scalar use the to_numpy() and reshape(-1,1) methods.

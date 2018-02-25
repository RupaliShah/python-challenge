import csv

file = "C:/LearnPython/Resources/Budget_Data_2.csv"

date = []
revenue = []
revenueChange = []
prevValue = 0

with open(file, 'r', newline='') as csvFile:
   csvReader = csv.reader(csvFile, delimiter=",")
   next(csvReader,None)
    
   for row in csvReader:
      date.append(row[0])
      revenue.append(int(row[1]))
       
      #revenue change between months
      value = int(row[1])
      change = prevValue - value
      revenueChange.append(change)
      prevValue = value

revenueChange.pop(0)

totalMonths = len(date)

totalRevenue = sum(revenue)

#greatest increase and decrease in revenue
greatestIncrease = max(revenueChange)
greatestDecrease = min(revenueChange)

result = zip(date, revenueChange)

for char, value in zip(date, revenueChange):
   if value == greatestIncrease:
      DateGreatestIncrease = char
   if value == greatestDecrease:
      DateGreatestDecrease = char
  
#average change in revenue
lenOfRevenueChange = len(revenueChange)
revenueChange = [abs(number) for number in revenueChange]
totalRevenueChange = sum(revenueChange)
averageRevenueChange = round(totalRevenueChange / lenOfRevenueChange)

print("Financial Analysis")
print("------------------------------------------")
print("Total Months: " + str(totalMonths))
print("Total Revenue: " + "$" + str(totalRevenue))
print("Average Revenue Change: " + "$" + str(averageRevenueChange))     
print("Greatest Increase in Revenue: " + str(DateGreatestIncrease) + " " + "(" + str(greatestIncrease) + ")")
print("Greatest Decrease in Revenue: " + str(DateGreatestDecrease) + " " + "(" + str(greatestDecrease) + ")")
        




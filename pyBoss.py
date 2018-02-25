#pyBoss
import os
import csv
import datetime 

emp_id =[]
new_firstname = []
new_lastname = []
new_dob = []
new_ssn = []
new_state = []

us_state_abbrev = {
    'Alabama': 'AL',
    'Alaska': 'AK',
    'Arizona': 'AZ',
    'Arkansas': 'AR',
    'California': 'CA',
    'Colorado': 'CO',
    'Connecticut': 'CT',
    'Delaware': 'DE',
    'Florida': 'FL',
    'Georgia': 'GA',
    'Hawaii': 'HI',
    'Idaho': 'ID',
    'Illinois': 'IL',
    'Indiana': 'IN',
    'Iowa': 'IA',
    'Kansas': 'KS',
    'Kentucky': 'KY',
    'Louisiana': 'LA',
    'Maine': 'ME',
    'Maryland': 'MD',
    'Massachusetts': 'MA',
    'Michigan': 'MI',
    'Minnesota': 'MN',
    'Mississippi': 'MS',
    'Missouri': 'MO',
    'Montana': 'MT',
    'Nebraska': 'NE',
    'Nevada': 'NV',
    'New Hampshire': 'NH',
    'New Jersey': 'NJ',
    'New Mexico': 'NM',
    'New York': 'NY',
    'North Carolina': 'NC',
    'North Dakota': 'ND',
    'Ohio': 'OH',
    'Oklahoma': 'OK',
    'Oregon': 'OR',
    'Pennsylvania': 'PA',
    'Rhode Island': 'RI',
    'South Carolina': 'SC',
    'South Dakota': 'SD',
    'Tennessee': 'TN',
    'Texas': 'TX',
    'Utah': 'UT',
    'Vermont': 'VT',
    'Virginia': 'VA',
    'Washington': 'WA',
    'West Virginia': 'WV',
    'Wisconsin': 'WI',
    'Wyoming': 'WY',
}

csvpath = os.path.join("..Resources", "employee_data2.csv")
csvpath = "c:\LearnPython\Resources\employee_data2.csv"
                      
with open(csvpath, 'r', newline ="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")
    next(csvreader,None)
    
    for row in csvreader:
        
        emp_id.append(row[0])
        
        firstname = row[1].split()[0]
        lastname = row[1].split()[1]
        new_firstname.append(firstname)
        new_lastname.append(lastname)
        
        d = datetime.datetime.strptime(row[2], '%Y-%m-%d')
        new_date_format = datetime.date.strftime(d, "%m/%d/%Y")
        new_dob.append(new_date_format)
        
        ssn = row[3]
        ssn1 = ssn.replace(ssn.split('-')[0],'***',1)
        ssn2 = ssn1.replace(ssn1.split('-')[1],'**',1)
        new_ssn.append(ssn2)
    
        state_abbr = us_state_abbrev.get(row[4],"none")
        new_state.append(state_abbr)
        
new_employee_data = zip(emp_id, new_firstname, new_lastname, new_dob, new_ssn, new_state)       
     
output_file = os.path.join("ModifiedData.csv")

with open(output_file, "w", newline="") as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(["Emp Id", "First Name", "Last Name", "DOB", "SSN", "State"])
    csvwriter.writerows(new_employee_data)
      
LEAP = 1
COMMON = 0
def leap(year)
  if (year % 400 == 0) or ((year % 100 !=0) and (year % 4 == 0) )
    LEAP
  else
    COMMON
  end
  
end

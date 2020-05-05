import numpy as np
import pandas as pd

a = np.array([
	['001','003','002'],
	['a','c','b'],
	['first','third','second']
])

print('a:\n',a,'\n')
'''
>>> a

array([['001', '003', '002'],
       ['a', 'c', 'b'],
       ['first', 'third', 'second']], dtype='<U6')
'''

b = a.transpose()

print('b:\n',b,'\n')
'''
>>> b

array([['001', 'a', 'first'],
       ['003', 'c', 'third'],
       ['002', 'b', 'second']], dtype='<U6')
'''

b_df = pd.DataFrame(b, columns=['index','letter','rank'])

print('b_df:\n',b_df,'\n')
'''
>>> b_df

  index letter    rank
0   001      a   first
1   003      c   third
2   002      b  second
'''

b_df_sorted = b_df.sort_values(by='index')

print('b_df_sorted:\n',b_df_sorted,'\n')
'''
>>> b_df_sorted

  index letter    rank
0   001      a   first
2   002      b  second
1   003      c   third
'''

c = np.array(b_df_sorted['rank'])

print('c:\n',c,'\n')
'''
>>> c

array(['first', 'third', 'second'], dtype=object)
'''


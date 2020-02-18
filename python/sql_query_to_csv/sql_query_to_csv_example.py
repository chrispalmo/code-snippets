from datetime import datetime

from sqlalchemy import create_engine
from sqlalchemy import Column, String, Integer, DateTime
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.ext.declarative import declarative_base

from sql_query_to_csv import sql_query_to_csv

Base = declarative_base()

# define model
class User(Base):
    __tablename__ = 'User'
    id       = Column(Integer, primary_key=True)
    name     = Column(String, nullable=False)
    fullname = Column(String, nullable=False)
    birth    = Column(DateTime)

engine = create_engine('sqlite:///db.sqlite')
Base.metadata.create_all(bind=engine)

users = [
    User(name='JH',
         fullname='Jimi Hendrix',
         birth=datetime(1942,11,27)),
    User(name='RJ',
         fullname='Robert Johnson',
         birth=datetime(1943,12,8)),
    User(name='JM',
         fullname='Jim Morrison',
         birth=datetime(1911,5,8))]

# create session
Session = sessionmaker()
Session.configure(bind=engine)
session = Session()

# add data
session.add_all(users)
session.commit()

# query database
query = session.query(User).all()

# output all users to csv
csv_1 = sql_query_to_csv(query)
print(csv_1)

# output all users to csv, excluding some columns
csv_2 = sql_query_to_csv(query, ["birth", "id", "_sa_instance_state"])
print(csv_2)

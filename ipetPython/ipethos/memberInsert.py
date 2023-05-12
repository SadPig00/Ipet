from flask import Flask, jsonify
from database import Database
import pandas as pd
# app = Flask(__name__)

db_class = Database()
df = pd.read_csv('pet_hos.csv',encoding='cp949')


for i in df.values:
    db_class.execute("insert into pethospital values(null,'"+str(i[0])+"','"+i[1]+"','"+str(i[2])+"','"+str(i[3])+"')")
    db_class.commit()

# query="insert into pethospital values(null,"
# db_class.executeAll()

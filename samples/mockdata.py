import datetime
import random

def creat_sensor_data():
    x = datetime.datetime.now()
    mockdata_list = []
    while len(mockdata_list) <= 4:
        num = round(random.uniform(0, 100),1)
        mockdata_list.append(num)
    sensor_data = {
        "record_date": x.strftime("%x"),
        "record_time": x.strftime("%X"),
        "device_id": str(random.randint(1,5)),
        "pH": round(random.uniform(0, 14),1),
        "EC": round(random.uniform(0, 1),3),
        "DO": mockdata_list[1],
        "temperature":round(random.uniform(0, 40),1) ,
        "turbidity": mockdata_list[1],
        "TDS": mockdata_list[2],
        "flow": mockdata_list[3],
        "level": mockdata_list[4]
    }
    return sensor_data
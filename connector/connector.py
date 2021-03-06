import socket
from time import sleep
import yaml

class Connector():
    @classmethod
    def slot(cls, path="../../config.yaml"):
        with open(path, 'r') as f:
            cfg = yaml.safe_load(f)
            # 从config.yaml文件中读取wifi模组的ip和port
            ip = cfg['connector']['STAIP']
            port = cfg['connector']['port']

        s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((ip, port))
        data = bytes.fromhex("a00101a2") # 打开第一路继电器
        s.send(data)
        s.close()

    @classmethod
    def unslot(cls, path="../../config.yaml"):
        with open(path, 'r') as f:
            cfg = yaml.safe_load(f)
            ip = cfg['connector']['STAIP']
            port = cfg['connector']['port']

        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((ip, port))
        data = bytes.fromhex("a00100a1") # 关闭第一路继电器
        s.send(data)
        s.close()

    @classmethod
    def unelectricity(cls, path="../../config.yaml"):
        with open(path, 'r') as f:
            cfg = yaml.safe_load(f)
            ip = cfg['connector']['STAIP']
            port = cfg['connector']['port']

        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((ip, port))
        data = bytes.fromhex("a00401a5")
        s.send(data)
        sleep(1)
        s.send(data)
        s.close()

    @classmethod
    def electricity(cls, path="../../config.yaml"):
        with open(path, 'r') as f:
            cfg = yaml.safe_load(f)
            ip = cfg['connector']['STAIP']
            port = cfg['connector']['port']

        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((ip, port))
        data = bytes.fromhex("a00400a4")
        s.send(data)
        sleep(1)
        s.send(data)
        s.close()

def test_unelectricity():
    Connector.unelectricity("../config.yaml")

def test_electricity():
    Connector.electricity("../config.yaml")

def test_slot():
    Connector.slot("../config.yaml")

def test_unslot():
    Connector.unslot("../config.yaml")


from value import Value
from type import PtrType
import operator
import labelname
from exceptions import SemanticError

def getField(t, fields):
    offset = 0
    for field in fields:
        offset += t.getFieldOffset(field)
        t = t.getFieldType(field)
    return offset, t

def genMemberAccess(val, fields):
    fieldOffset, fieldType = getField(val.getType(), fields)
    if val.getIndirLevel() == 1:
        if fieldOffset == 0:
            return Value(val.getLocation(), fieldType, 1, val.getSource(), False), ""
        else:
            return Value(val.getLocation(), fieldType, 1, f"({val.getSource()}) + {fieldOffset}", False), ""
    else:
        raise RuntimeError("WTF is that")

def genMemberAddress(resultLoc, val, fields):
    fieldOffset, fieldType = getField(val.getType(), fields)
    if val.getIndirLevel() == 1:
        if fieldOffset == 0:
            return Value(val.getLocation(), PtrType(fieldType), 0, val.getSource(), True), ""
        else:
            return Value(val.getLocation(), PtrType(fieldType), 0, f"({val.getSource()}) + {fieldOffset}", True), ""
    else:
        raise RuntimeError("WTF is that")

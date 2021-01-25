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

def genMemberAccess(resultLoc, val, fields):
    fieldOffset, fieldType = getField(val.getType(), fields)
    if val.getIndirLevel() == 1:
        if fieldOffset == 0:
            return val.withType(fieldType), ""
        else:
            return Value(val.getLocation(), fieldType, 1, f"({val.getSource()}) + {fieldOffset}"), ""
    else:
        raise RuntimeError("WTF is that")

def genMemberAddress(resultLoc, val, fields):
    fieldOffset, fieldType = getField(val.getType(), fields)
    if val.getIndirLevel() == 1:
        if fieldOffset == 0:
            return Value(val.getLocation(), PtrType(fieldType), 0, val.getSource()), ""
        else:
            return Value(val.getLocation(), PtrType(fieldType), 0, f"({val.getSource()}) + {fieldOffset}"), ""
    else:
        raise RuntimeError("WTF is that")

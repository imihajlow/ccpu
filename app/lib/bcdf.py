#!/usr/bin/env python3
class Bcdf:
	def __init__(self):
		self.exp = 0
		self.sign = False
		self.man = [0] * 14

	def __str__(self):
		return "{}{}.{}e{}".format("+" if not self.sign else "-", self.man[0], "".join(str(x) for x in self.man[1:]), self.exp)

	def print(self, width):
		# either 123.456 or 1.352325e+111
		# min width: -1e+127 - 7 char
		expLength = 1
		if self.exp < 0:
			if self.exp <= -10:
				expLength += 1
			if self.exp <= -100:
				expLength += 1
		else:
			if self.exp >= 10:
				expLength += 1
			if self.exp >= 100:
				expLength += 1
		width -= 3 + expLength
		if self.sign:
			yield '-'
			width -= 1
		yield chr(ord('0') + self.man[0])
		if width != 0:
			yield '.'
			width -= 1
		i = 1
		while width != 0:
			yield chr(ord('0') + self.man[i])
			i += 1
			width -= 1
		yield 'e'
		exp = self.exp
		if exp >= 0:
			yield '+'
		else:
			yield '-'
			exp = -exp
		large = False
		if exp >= 100:
			yield '1'
			exp -= 100
			large = True
		d, m = divmod10(exp)
		if d > 0 or large:
			yield chr(ord('0') + d)
		yield chr(ord('0') + m)


def divmod10(a):
	return divmod(a, 10)

def bcdfNormalize(a):
	delta = 0
	for i in range(14):
		if a.man[i] != 0:
			break
		delta += 1
	if a.exp - delta < -128:
		delta = a.exp + 128
	a.exp = a.exp - delta
	for i in range(14 - delta):
		a.man[i] = a.man[i + delta]
	for i in range(14 - delta, 14):
		a.man[i] = 0


def bcdfAdd(a, b):
	if a.sign != b.sign:
		b.sign = not b.sign
		return bcdfSub(a, b)
	r = Bcdf()
	r.sign = a.sign
	expDiff = a.exp - b.exp
	if expDiff < 0:
		a,b = b,a
		expDiff = -expDiff
	r.exp = a.exp
	carry = 0
	for i in reversed(range(14)):
		s = a.man[i] + carry
		bi = i - expDiff
		if bi >= 0:
			s += b.man[bi]
		carry, s = divmod10(s)
		r.man[i] = s
	if carry > 0:
		r.exp += 1
		for i in reversed(range(1,14)):
			r.man[i] = r.man[i - 1]
		r.man[0] = carry
	return r

def bcdfSub(a, b):
	if a.sign != b.sign:
		b.sign = not b.sign
	r = Bcdf()
	expDiff = a.exp - b.exp
	r.sign = a.sign
	if expDiff < 0:
		a,b = b,a
		expDiff = -expDiff
		r.sign = not r.sign
	elif expDiff == 0:
		for i in range(14):
			if a.man[i] > b.man[i]:
				break
			elif a.man[i] < b.man[i]:
				a,b = b,a
				r.sign = not r.sign
				break
	borrow = 1
	for i in reversed(range(14)):
		d = a.man[i] + 10 - 1 + borrow
		bi = i - expDiff
		if bi >= 0:
			d = d - b.man[bi]
		borrow, d = divmod10(d)
		r.man[i] = d
	bcdfNormalize(r)
	return r


if __name__ == '__main__':
	a = Bcdf()
	a.exp = 0
	a.man[0] = 1
	a.man[1] = 5

	b = Bcdf()
	b.exp = 0
	b.man[0] = 9
	b.man[1] = 7
	b.man[2] = 6
	print(a)
	print(b)
	print(bcdfAdd(b,a))

	b.man[0] = 0
	b.man[13] = 9
	b.exp = -127
	bcdfNormalize(b)
	print(b)

	a = Bcdf()
	b = Bcdf()
	a.exp = 0
	a.man[0] = 1
	a.man[1] = 5

	b.exp = -1
	b.man[0] = 2
	b.man[1] = 5
	print()
	print(a)
	print(b)
	print(bcdfSub(a,b))
	print(bcdfSub(b,a))

	a = Bcdf()
	b = Bcdf()
	a.exp = -99
	a.sign = True
	a.man[0] = 1
	a.man[1] = 5

	b.exp = 0
	b.man[0] = 1
	b.man[1] = 7
	print()
	print(a)
	print(b)
	print(bcdfSub(a,b))
	print(bcdfSub(b,a))

	print()
	for i in range(7, 17):
		print("".join(a.print(i)))

describe 'String', ->
  describe 'trunc', ->
    it 'should truncate a String to 8', ->
      str = 'Testing a string'
      expect(str.trunc(8)).toEqual 'Testing...'
    it 'should truncate a String to 9', ->
      str = 'Testing a string'
      expect(str.trunc(9)).toEqual 'Testing ...'
    it 'should truncate a String to 10', ->
      str = 'Testing a string'
      expect(str.trunc(10)).toEqual 'Testing a...'
    it 'should truncate a string on first word boundary', ->
      str = 'Testing a string'
      expect(str.trunc(9,true)).toEqual 'Testing...'
      expect(str.trunc(10,true)).toEqual 'Testing...'
    it 'should truncate a string on second word boundary', ->
      str = 'Testing a string'
      expect(str.trunc(11,true)).toEqual 'Testing a...'
      expect(str.trunc(12,true)).toEqual 'Testing a...'
  describe 'stripHTML', ->
    it 'should strip <i>', ->
      str = '<i>italic</i>'
      expect(str.stripHTML()).toEqual 'italic'
    it 'should strip <b>', ->
      str = '<b>bold</b>'
      expect(str.stripHTML()).toEqual 'bold'
    it 'should strip <strong>', ->
      str = '<strong>bold</strong>'
      expect(str.stripHTML()).toEqual 'bold'
    it 'should strip <br/>', ->
      str = '<br/>normal'
      expect(str.stripHTML()).toEqual 'normal'
    it 'should strip <p/>', ->
      str = '<p/>normal'
      expect(str.stripHTML()).toEqual 'normal'
    it 'should strip <b/>', ->
      str = '<b/>normal'
      expect(str.stripHTML()).toEqual 'normal'

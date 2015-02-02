String.prototype.trunc = String.prototype.trunc || (n, useWord) ->
  toLong = this.length>n
  s_ = if toLong then this.substr(0,n-1) else this
  s_ = if useWord && toLong then s_.substr(0,s_.lastIndexOf(' ')) else s_
  if toLong then s_ + '...' else s_

String.prototype.stripHTML = String.prototype.stripHTML || ->
  this.replace(/<[^>]+>/gm, '').replace(/&[^;]+;/gm, '')

class Mentor < User
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :tags
  has_one :angel

  attr_accessible :team_ids, :angel, :slug

  def angel= angel
    self.angel.update_attributes angel
  end

  def worked_with
    self.angel && self.angel.worked_with || []
  end

  def update_from_angel angel
    self.last_name = angel.name unless self.last_name
    self.description = angel.bio unless self.description
    update_avatar angel
    update_links angel
  end

  def mentors
    [self]
  end

  def angellist_url
    named_link :angellist_url
  end

  def linkedin_url
    named_link :linkedin_url
  end

  private

  def named_link name
    self.links = {} unless self.links
    link = self.links[name]
    link[:url] unless link.nil?
  end

  def update_links angel
    self.links = {} unless self.links
    self.links[:angellist_url] = { url: angel.angellist_url, name: 'AngelList' }
    self.links[:twitter_url] = { url: angel.twitter_url, name: 'Twitter' }
    self.links[:linkedin_url] = { url: angel.linkedin_url, name: 'LinkedIn' }
    self.links[:facebook_url] = { url: angel.facebook_url, name: 'Facebook' }
    self.links[:github_url] = { url: angel.facebook_url, name: 'GitHub' }
  end

  def update_avatar angel
    str_io_max =  OpenURI::Buffer.const_get 'StringMax'
    OpenURI::Buffer.const_set 'StringMax', 4096000
    self.avatar = open(angel.image)
    OpenURI::Buffer.const_set 'StringMax', str_io_max
  end
end

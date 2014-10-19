module AresMUSH
  class Character
    has_many :friendships, :inverse_of => :character, :dependent => :destroy
    has_many :friends_of, :class_name => 'AresMUSH::Friendship', :inverse_of => :friend, :dependent => :destroy
    field :handle_friends, :type => Array, :default => []
    
    def has_friended_char_or_handle?(other_char)
       has_friended_char?(other_char) || has_friended_handle?(other_char)
    end
    
    def has_friended_char?(other_char)
      friends.include?(other_char)
    end
    
    def has_friended_handle?(other_char)
      handle_friends.include?(other_char.handle)
    end
    
    def friends
      friendships.map { |f| f.friend }
    end
  end  
  
  class Friendship
    include SupportingObjectModel
    
    belongs_to :character, :inverse_of => :friendships
    belongs_to :friend, :class_name => 'AresMUSH::Character', :foreign_key =>'friend_id', :inverse_of => :friends_of
  end
end
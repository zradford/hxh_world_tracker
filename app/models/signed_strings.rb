module SignedStrings
  refine Integer do 
    def to_ss
      self <= 0 ? self.to_s : "+#{self.to_s}" 
    end
  end
end
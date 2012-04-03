class Dash::DashPresenter
  def totalbiz
    Business.count
  end

  def approvedbiz
    Business.where(:approved => true).count
  end

  def pendingbiz
    Business.where(:approved => false).count
  end

  def totalpeople
    Person.count
  end

  def approvedpeople
    Person.where(:approved => true).count
  end

  def pendingpeople
    Person.where(:approved => false).count
  end

  def totalarticles
    Article.count
  end

  def publishedarticles
    Article.where(:published => true).count
  end

  def unpublishedarticles
    Article.where(:published => false).count
  end

  def totalusers
    User.count
  end

  def activeusers
    User.where(:active => true).count
  end

  def linkedinusers
    User.where(:linkedinid => nil).count
  end
end

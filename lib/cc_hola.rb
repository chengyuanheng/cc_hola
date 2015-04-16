class CcHola
  def self.controllers
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.map do |controller|
      if controller =~ /_controller/
        controller.camelize.gsub(".rb","").constantize.to_s
      end
    end.compact!
  end

  def self.controllers_actions
    ApplicationController.subclasses.map do |controller|
      {controller.to_s=>controller.action_methods.map{|action|action}}
    end << {"ApplicationController"=>ApplicationController.action_methods.map{|action| action }}
  end

  def self.actions
    (ApplicationController.subclasses.map do |controller|
      controller.action_methods.map{|action|action}
    end<<ApplicationController.action_methods.map{|action| action }).flatten.uniq
  end

  def self.notes
    %x[rake notes]
  end

end
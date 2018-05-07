class BegripsController < InlineFormsController
  set_tab :begrip

  # override index to scope @Klass
   def index
     @objects ||= @Klass
     @search = params[:search] || ""
     search = '%' + @search + '%'
     unless @search.empty?
       @objects = @objects.where("name LIKE ?", search)
     end
     @objects = @objects.accessible_by(current_ability) if cancan_enabled?
     super
   end


end

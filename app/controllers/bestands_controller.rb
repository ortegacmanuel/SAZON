class BestandsController < InlineFormsController
  set_tab :bestand

  def download
    @bestand = Bestand.find_by(slug: params[:slug])
    return redirect_to '/view/not_found' if @bestand.nil?
    return redirect_to @bestand.file.url
  end
end

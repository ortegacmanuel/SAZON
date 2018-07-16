class DocumentsController < InlineFormsController
  set_tab :document
  include ApplicationHelper

  def view
    @document = Document.find_by(slug: params[:slug])
    return redirect_to '/view/not_found' if @document.nil?
    @content = @document.content
    respond_to do |format|
      format.html {
        @content = add_tooltips @content, 'html'
        @masonry_picture_width = @document.masonry_column_width
        @masonry_column_width = @masonry_picture_width + @document.masonry_gutter_width
        render layout: 'view'
      }
      format.pdf {
        @masonry_picture_width = @document.masonry_column_width
        @masonry_column_width = @masonry_picture_width + @document.masonry_gutter_width
        html = render_to_string(layout: 'pdf')
         filename = "#{Time.now.to_s(:db)[0..9]}_#{@document.clean_name}.pdf"
         if Rails.env.production?
           # generate the pdf
           html = html.gsub(/\/assets\//, 'https://sazon.id-arte.net/assets/')
           html = html.gsub(/\/uploads\//, 'https://sazon.id-arte.net/uploads/')
           pdf = PDFKit.new(html).to_pdf
           send_data(pdf, :filename => filename, :type => 'application/pdf')
         else
           # generate the pdf
           html = html.gsub(/\/assets\//, 'http://127.0.0.1:3000/assets/')
           html = html.gsub(/\/uploads\//, 'http://127.0.0.1:3000/uploads/')
           File.open("#{Rails.root}/pdfs/#{filename}.html", "w+b") {|f| f.write(html)}
           pdf = PDFKit.new(html).to_pdf
           send_data(pdf, :filename => filename, :type => 'application/pdf')
         end
       }
    end
  end

  def module_view
    @document = Document.find_by(slug: params[:slug])
    return redirect_to '/view/not_found' if @document.nil?
    respond_to do |format|
      format.pdf {
        @masonry_picture_width = @document.masonry_column_width
        @masonry_column_width = @masonry_picture_width + @document.masonry_gutter_width
        html = render_to_string(layout: 'pdf')
         filename = "#{Time.now.to_s(:db)[0..9]}_#{@document.clean_name}.pdf"
         if Rails.env.production?
           # generate the pdf
           html = html.gsub(/\/assets\//, 'https://sazon.id-arte.net/assets/')
           html = html.gsub(/\/uploads\//, 'https://sazon.id-arte.net/uploads/')
           pdf = PDFKit.new(html).to_pdf
           send_data(pdf, :filename => filename, :type => 'application/pdf')
         else
           # generate the pdf
           html = html.gsub(/\/assets\//, 'http://127.0.0.1:3000/assets/')
           html = html.gsub(/\/uploads\//, 'http://127.0.0.1:3000/uploads/')
           File.open("#{Rails.root}/pdfs/#{filename}.html", "w+b") {|f| f.write(html)}
           pdf = PDFKit.new(html).to_pdf
           send_data(pdf, :filename => filename, :type => 'application/pdf')
         end
       }
    end
  end

  def module_begrips
    @document = Document.find_by(slug: params[:slug])
    @begrips = @document.module_begrips
    @isms = @document.module_isms
    render layout: 'view'
  end

  # def css
  #   render body: Document.find(ROOT_ID).css, content_type: "text/css"
  # end

end

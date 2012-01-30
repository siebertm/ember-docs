require 'fileutils'

require 'ember_docs/server'

module EmberDocs
  class Generator

    attr_reader :input_dirs
    attr_reader :output_dir
    attr_reader :template
    attr_reader :smartdown
    attr_reader :verbose
    attr_reader :exclude

    def initialize(directories, options={})
      @input_dirs = directories
      @output_dir = File.expand_path(options[:output_dir])
      @smartdown  = false
      @exclude    = options[:exclude]
      @verbose    = options[:verbose]
    end

    def command
      @command ||= begin
        run_js_path = File.expand_path("../../../vendor/jsdoc/app/run.js", __FILE__)
        command = "#{run_js_path} -a -v -r=20 -t=\"#{template}\" #{input_dirs.map{|d| %{"#{d}"} }.join(' ')} " <<
                      "-d=\"#{output_dir}\" -f=class.js -l=Docs.Class"
        command << exclude.map{|e| %{ -E="#{e}"} }.join if exclude
        command << " --smartdown" if smartdown
        command
      end
    end

    def generate
      prep
      run_command
    end

    def preview
      prep
      run_command
      run_server
    end

    private

      def prep
        FileUtils.rm_rf output_dir
        FileUtils.mkdir_p File.dirname(output_dir)
      end

      def run_command
        puts "#{command}\n\n" if verbose
        verbose ? system(command) : `#{command}`

        copy_files

        puts "Finished Building\n\n"
      end

      def copy_files
        # Copy other files to output
        path = File.join(template, "output")
        if File.directory?(path)
          puts "Copying additional files" if verbose
          # This is stupid, but necessary to copy only the contents
          Dir["#{path}/*"].each{|p| FileUtils.cp_r(p, output_dir) }
        end
      end

      def run_server
        Server.new(output_dir).start
      end

  end

  class HtmlGenerator < Generator

    def initialize(directories, options={})
      super
      @template = lookup_template(options[:template])
      @smartdown = true
    end

    private

      def lookup_template(name)
        path = File.expand_path("../templates/#{name}", __FILE__)
        File.exist?(path) ? path : File.expand_path(name)
      end

  end

end

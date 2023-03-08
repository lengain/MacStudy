# frozen_string_literal: true
require 'xcodeproj'
require 'rexml/document'
require 'xcodeproj/plist'
require 'json'
include REXML
include Xcodeproj

class SCCodeItem
  attr_accessor :title
  attr_accessor :description
  attr_accessor :code
  attr_accessor :filePath
  attr_accessor :className

  def to_s
    s = super
    "#{s}\ntitle:#{@title}description:#{@description}#{@code}"
  end

  def to_hash
    @title.chomp!
    @description.chomp!
    {
      "title": @title,
      "description": @description,
      "filePath": @filePath,
      "className": @className,
    }
  end

end

class DocumentGenerator

  attr_reader :project
  attr_accessor :project_path

  def initialize
    super
    @project_path = search_proj
    @project_name = "MacStudy"
    @document_dir = __dir__ + '/' + @project_name + '/' + 'Documents'
    Dir::mkdir(@document_dir) if !Dir::exist?(@document_dir)
    @project = Xcodeproj::Project.open(@project_path)
    if @project.main_group == nil
      raise "Never find main group"
    end
    @main_group = @project.main_group.children[0]
    @main_target = @project.targets.first
    prepare_document_group

  end

  def start
    #准备文档文件
    prepare_sidebar
    #添加文件到工程
    add_file_to_group
    #保存
    @project.save
  end

  def prepare_sidebar
    sidebar_path = __dir__ + '/' + @project_name + '/Sidebar.plist'
    if File.exist?(sidebar_path)
      sidebar = Plist.read_from_path(sidebar_path)
      sidebar.each do |element|
        element.each { |key, value|
          puts key
          kit_dir_name = value["title"] + '-doc'
          kit_dir_path = __dir__ + '/' + @project_name + '/' + kit_dir_name
          code_item_array = generate_code_array(kit_dir_path)
          if code_item_array.length > 0
            generate_kit_menu(code_item_array, value["title"])
          end
        }
      end
    else
      raise "Sidebar.plist don't exist"
    end
  end

  # @param [[SCCodeItem]] code_item_array
  def generate_kit_menu(code_item_array, kit_name)
    menu_array = Array.new
    code_item_array.each do |code_item|
      to_hash = code_item.to_hash
      menu_array.push to_hash if to_hash != nil
      generate_code_markdown code_item
    end

    file_path = @document_dir + '/' + kit_name + '.json'
    f = File.new(file_path, "w+")
    f.puts(menu_array.to_json)
    f.close
  end

  # @param [SCCodeItem] code_item
  def generate_code_markdown(code_item)
    code = "
  ``` swift
  #{code_item.code}
  ```
"
    file_path = @document_dir + '/' + code_item.title + '.md'
    f = File.new(file_path, "w+")
    f.puts(code)
    f.close
  end

  # @param [String] kit_dir_path
  def generate_code_array(kit_dir_path)
    code_item_array = Array.new
    if File.exist?(kit_dir_path)
      swift_file_type = ".swift"
      Dir::entries(kit_dir_path).each do |swift_file|
        if swift_file.end_with?(swift_file_type)
          swift_file_path = kit_dir_path + '/' + swift_file
          puts(swift_file_path)
          begin
            f = File.open(swift_file_path, "rb")
            swift_code = f.read
            f.close
            code_item = handle_code(swift_code)
            code_item.filePath = kit_dir_path + "/" + swift_file if code_item != nil
            swift_file.slice!(swift_file_type)
            code_item.className = swift_file if code_item != nil
            code_item_array.push(code_item) if code_item != nil
          end
        end
      end
    end
    code_item_array
  end

  # @param [String?] swift_code
  def handle_code(swift_code)
    code_item = SCCodeItem.new
    title_pattern = Regexp.new("/// title.+\n")
    swift_code.match(title_pattern) do |data|
      title = data.to_s
      title.slice!("/// title : ")
      code_item.title = title
    end

    desc_pattern = Regexp.new("/// description.+\n")
    swift_code.match(desc_pattern) do |data|
      desc = data.to_s
      desc.slice!("/// description : ")
      code_item.description = desc
    end

    code_pattern = Regexp.new("/// start[\\s\\S]*/// end")
    swift_code.match(code_pattern) do |data|
      code = data.to_s
      code.slice!("/// start")
      code.slice!("/// end")
      code_item.code = code
    end
    code_item.title == nil ? nil : code_item
  end

  def prepare_document_group
    # 新建或查找Documents文件夹
    @document_group = @main_group["Documents"]
    if @document_group == nil
      @document_group = @main_group.new_group("Documents", @document_dir)
    end
    # 清空Documents文件夹
    if @document_group.children != nil
      while @document_group.children.count > 0 do
        child = @document_group.children.last
        puts "移除build phase:#{child.display_name}"
        # 移除resources
        @main_target.resources_build_phase.remove_file_reference(child)
        # 从工程中移除
        child.remove_from_project
      end
    end
    # @project.save
    # exit 0
    Dir::entries(@document_dir).each do |item|
      if !File::directory?(item) && !item.start_with?('.')
        file_path = @document_dir + '/' + item
        File.delete(file_path) if File.exist?(file_path)
        puts "删除文件:#{file_path}"
      end
    end
  end

  def add_file_to_group
    # Documents文件夹添加文件
    file_array = Array.new
    Dir::entries(@document_dir).each do |item|
      if !File::directory?(item) && !item.start_with?('.')
        file_path = @document_dir + '/' + item
        # 新建file Ref
        file = @document_group.new_file(file_path)
        # @main_target.add_file_references([file])
        # 添加File Ref到Resource
        file_array.push(file)
        puts "添加文件:#{item}"
      end
    end
    @main_target.add_resources(file_array)
  end

  def search_proj (path = __dir__)
    return if path == nil
    paths = Dir::entries(path)
    suffix = '.xcodeproj'
    paths.each { |item|
      if File::directory?(item) && item.end_with?(suffix)
        return path + '/' + item
      end
    }
    nil
  end

end

dg = DocumentGenerator.new
dg.start
exit!
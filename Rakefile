require 'erb'
require 'yaml'
require 'open3'

s6_version='v1.21.2.1'
template = File.read(File.expand_path('../Dockerfile.template', __FILE__) )
targets = YAML.load(File.read(File.expand_path('../buildtargets.yml', __FILE__) ))


task :default do
  puts `rake -vT`
end

desc 'run export_all and build_all'
task :all do
  Rake::Task['export_all'].invoke
  Rake::Task['build_all'].invoke
end

desc 'create all dockerfiles'
task :export_all do
  targets.each_pair do |k, v|
    v.each do |tag|
      # invoke does not allow twice
      Rake::Task['export'].execute(image_name: k, image_tag: tag)
    end
  end
end

desc 'build all docker images'
task :build_all do
  targets.each_pair do |k, v|
    v.each do |tag|
      # invoke does not allow twice
      Rake::Task['build'].execute(image_name: k, image_tag: tag)
    end
  end
end

desc 'create dockerfile'
task :export, ['image_name', 'image_tag'] do |task, args|
  image_name = args[:image_name]
  image_tag = args[:image_tag]
  if File.exists?(File.expand_path("../Dockerfile.part.#{image_name}/", __FILE__))
    partfile = File.read(File.expand_path("../Dockerfile.part.#{image_name}/", __FILE__))
  else
    partfile = ''
  end

  FileUtils.mkdir_p(File.expand_path("../dist/#{image_name}/#{image_tag}/", __FILE__))
  File.open(File.expand_path("../dist/#{image_name}/#{image_tag}/Dockerfile", __FILE__), 'w') do |f|
    f.puts('# this file is created by rake exprt task.')
    f.puts(ERB.new(template).result(binding))
  end
end

desc 'build docker image'
task :build, ['image_name', 'image_tag'] do |task, args|
  dockerfile = File.expand_path("../dist/#{args[:image_name]}/#{args[:image_tag]}/Dockerfile", __FILE__)
  image_str = 'mobingi/baseimage' + ':' + [args[:image_name], args[:image_tag].to_s].join('-')
  unless File.exists?(dockerfile)
    puts "#{dockerfile} not found"
    return
  end

  Dir.chdir(File.expand_path('../', __FILE__)) do
    cmd = "docker build -f #{dockerfile} -t #{image_str} --squash ."
    puts cmd
    Open3.popen3(cmd) do |i, o, e, w|
      o.each { |line| puts line }
      e.each { |line| puts line }
      exit_status = w.value
      unless exit_status.success?
        abort "FAILED !!! #{image_str}"
      end
    end
  end
end

task :example do
  image_str = 'mobingidocker-example:latest'
  Dir.chdir(File.expand_path('../example', __FILE__)) do
    cmd = "docker build -f Dockerfile -t #{image_str} --squash ."
    puts cmd
    Open3.popen3(cmd) do |i, o, e, w|
      o.each { |line| puts line }
      e.each { |line| puts line }
      exit_status = w.value
      unless exit_status.success?
        abort "FAILED !!! #{image_str}"
      end
    end
  end
end

namespace :push do
  desc 'push images from local(already logged in to docker.io)'
  task :fromlocal do
    targets.each_pair do |k, v|
      v.each do |tag|
        image_str = 'mobingi/baseimage' + ':' + [k, tag.to_s].join('-')
        cmd = "docker push #{image_str}"
        puts cmd
        Open3.popen3(cmd) do |i, o, e, w|
          o.each { |line| puts line }
          e.each { |line| puts line }
          exit_status = w.value
          unless exit_status.success?
            abort "FAILED to Push!!! #{image_str}"
          end
        end
      end
    end
  end

  desc 'generate description for dockerhub'
  task :description do
    targets.each_pair do |k, v|
      v.each do |tag|
        tag_str = [k, tag.to_s].join('-')
        image_path = "https://github.com/mobingidocker/dockerimage-boilerplate/blob/master/dist/#{k}/#{tag}/Dockerfile"
        puts %Q{- [#{tag_str}](#{image_path})}
      end
    end
  end
end

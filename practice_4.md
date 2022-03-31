# 4-1  Rails�R���|�[�l���g��MVC�̊�b�m��
## 1 MVC�̖������\������ARails�̊e�R���|�[�l���g�̖��O��񋓂��A���ꂼ��̖���������������������B

- Active Record  
���f���̋@�\�̕⏕
- Action Controller  
�R���g���[���[�̕⏕
- Action view  
�r���[�Ɋւ���@�\�̕⏕
- Action dispauch  
���[�e�B���O�Ɋւ���@�\�̕⏕

### ����

- Active Record  
�����F���\�[�X�Ǘ�
- Action View  
�����F���[�U�[�C���^�[�t�F�[�X
- Action Controller  
�����F���\�[�X����
- Action Dispatch(���[�^�[)  
�����FWeb���N�G�X�g�̉�͂ƃ��[�e�B���O

## 2 ���[�^�[�̖����ɂ��ĊȒP�ɐ������A���[�^�[�ƃR���g���[�^�[�̃R���|�[�l���g�̊֌W�ɂ��āA�������Ă��������A

### ��
���[�^�[��HTTP���N�G�X�g���󂯎��A���N�G�X�g�ɏ]���āA�ǂ̃R���g���[���[���ĂԂ̂������߂�ꏊ�ł��B  
�R���g���[���[�̓��[�^�[�̖��߂ɏ]���A�K�v�ȃ��\�[�X�����f���o�R�Ńf�[�^�x�[�X��蒊�o���閽�߂��o������A���[�U�[�C���^�[�t�F�[�X�ɕ\������HTML�����悤�r���[�Ɏw�߂��o�����������܂��B

### ����
���[�^�[�̖�����Web���N�G�X�g�̉�͂ƃ��[�e�B���O��S���Ă��܂��B  
���[�^�[�̓A�N�V�����̐U�蕪�����A�R���g���[���[�̓A�N�V�����̐�����s���Ƃ����֌W�ɂȂ��Ă��܂��B

## 3 ���[������̃R���|�[�l���g�ɂ��āA���̖��O�������A�������ȒP�ɐ������Ă��������B

### ��
Action Mailer ���[���𑗂�@�\�����B

### ����
Action Mailer ���[���̑���M�ɂ����āA�N���C�A���g����@�\�⃁�[���e���v���[�g�̐����@�\��񋟂��܂��B

#### ��̓I�ɂł��邱��
- �V�K�o�^���ꂽ���ɁA���[�U�[�ɑ΂��Ċm�F���[��
- �G���[�������ɁA�Ǘ��҂Ƀ��[��

## 4 Ruby�̊g�����\�b�h��񋟂���R���|�[�l���g�ɂ��Đ������Ă��������B

### ��
�킩��܂���B

### ����
Active Support  
Ruby�̊g�����\�b�h�Ȃǂ�񋟂��܂��B�N�����ɕW���őg�ݍ��܂�܂��B

## 5 Rails 5�ȍ~�ŐV�����������ꂽ2�̃R���|�[�l���g�ɂ��Đ������Ă��������B

### ��
�킩��܂���B

### ����
Action Cable(�A�N�V�����P�[�u��)  
�N���C�A���g�ƃT�[�o�[�Ԃōs���`���b�g�̂悤�ȃ��A���^�C���ʐM�@�\��񋟂��܂��B
#### �����ł���̂�
- �`���b�g�A�v��������

Active Storage  
Active Record�ƘA�g�����摜�E����Ȃǂ̃t�@�C���A�b�v���[�h�A�Q�Ƌ@�\��񋟂��܂��B  
Amazon S3�Ȃǂ̂悤�ȁA�N���E�h��̃f�[�^�n�搳�K�T�[�r�X�ƃX�}�[�g�ɘA�g���܂��B  
#### �����ł���̂�
- ����܂�Refile���g���Ă����̂��A�W���ŉ摜�A�b�v���[�h���\�ɂȂ���

## 6 Rails�t���[�����[�N�̋N���v���Z�X�Ȃǂ�񋟂���R���|�[�l���g�ɂ��Đ������Ă��������B

### ��
�킩��܂���B

### ����
Railties  
Rails�t���[�����[�N�̏����ƂȂ�R���|�[�l���g�B  
�A�v���P�[�V�����̋N���v���Z�X��ARails�R�}���h���s�̃C���^�[�t�F�[�X�A�����Rails�W�F�l���[�^�[��񋟂��܂��B

## 7 ERB�̖����ɂ��āA�ȒP�ɐ������Ă��������B

### ��
HTML�̒���Ruby�𖄂ߍ��񂾎��ɕ\���̃T�|�[�g������p�b�P�[�W�B

### ����
�r���[�e���v���[�g�Ȃǂɖ��ߍ��߂镶�͖��ߍ��ݗp��Ruby�X�N���v�g�B  
�g���q��.erb�̃t�@�C���Ƃ��ċL�q���邱�ƂŁA���ߍ��܂�Ă���Ruby�R�[�h�����s���A�l�̖��ߍ��݂��s���B
#### �X�N���v�g�Ƃ́H
�@�B��ւ̕ϊ����ȗ����āA���ߎ��s�ł���悤�ɂ����v���O���~���O����̂��ƁB

## 8 Rails 5�̃f�t�H���g��Web�T�[�o�[�@�\�ɂ��ĊȒP�ɐ������Ă��������B

### ��
Puma�B

### ����
Puma  
�����I�ȃX���b�h���g�p�������񏈗��������ł���B  
Puma�̂������ŁA�J�����ɑ�����Web�A�v���P�[�V�����̊m�F���s�����Ƃ��ł���B

## 9 Rake�̖����ɂ��Đ������Ă��������B

### ��
�킩��܂���B

### ����
Ruby�ō��ꂽ�\�z�m�F�p�̃c�[���B
Rails���ɂ����ẮA�f�[�^�x�[�X�̃}�C�O���[�V�����ȂǂŎg�p����B


# 4-2 Rails�̃f�B���N�g���\��

Rails�J����i�߂Ă�����ŁA�������ꂽ�t���[�����[�N�̊e�f�B���N�g����t�@�C����

- �ǂ̂悤�ȏꍇ�ɂ������g�p����̂�
- �ǂ̂悤�Ȗ������ʂ����̂�

��m���Ă������Ƃ��d�v

### �f�B���N�g��

- .git
git�����p����f�B���N�g���Bgit�Ƃ̓o�[�W�����Ǘ��c�[���̂��ƁB

- app
�A�v���P�[�V�����Ɋւ����񂪓����Ă���B���f���A�R���g���[���[�A�r���[�͂��̒��ɂ���B

- bin
�A�v���P�[�V�����̋N���Ɏg�p����v���O�����i�X�N���v�g�t�@�C���j���Ǘ�����f�B���N�g���B

- config
���s���Ɋւ���ݒ���

- db
�f�[�^�x�[�X�֘A�̐ݒ���  
�X�L�[�}�t�@�C����}�C�O���[�V�����t�@�C�����������}�C�O���[�g�f�B���N�g�������݂���B

- lib
�����̃A�v���P�[�V�����Ԃŋ��L���郉�C�u�������Ǘ����邽�߂̃f�B���N�g���B

- log
�A�v���P�[�V�����̎��s���̃��O�t�@�C����ێ�����f�B���N�g���B

- public
�A�b�v���[�h�摜�Ƃ������ÓI�t�@�C���A�ÓI�g�b�v�y�[�W�ȂǁA�ÓI�Ȍ��J���\�[�X���������߂̃f�B���N�g���B

- storage
Active storage�̃f�t�H���g���[�J���X�g���[�W

- test
Rails�W���̊e��e�X�g�p�̃R�[�h�t�@�C����e�X�g�f�[�^�i�t�B�N�X�`���j�Ȃǂ��Ǘ����邽�߂̃f�B���N�g���B

- tmp
Rails�ғ����̈ꎞ�I�ȏ��i�L���b�V���A�v���Z�XID(pid)�A�Z�b�V�����j�Ȃǂ��Ǘ�����f�B���N�g���B

- vendor
�T�[�h�p�[�e�B���̃R�[�h��f�ނ������Ă����f�B���N�g���B

### �t�@�C��

- .gitignore
git�̃o�[�W�����Ǘ��Ώۂ���O���ׂ��t�@�C���Ȃǂ��L�q����t�@�C��

- .ruby-version
Ruby�̃o�[�W�������Ǘ��B

- config.ru
Rack��Rails�T�[�o�[�̋N���̂��߂Ɏg�p����ݒ�t�@�C��

- Gemfile
Gem�p�b�P�[�W�̐ݒ�t�@�C��

- Gemfile.lock
bundle install���ꂽGem�p�b�P�[�W�̈ˑ��֌W���Ǘ����邽�߂̃t�@�C���B  
���̃t�@�C���Ɋ�Â��ăp�b�P�[�W�Ǘ�����Ă���B
  - �⑫
    bundle install�����s����ƁAGemfile.lock�Ƃ����t�@�C�������������B  
    �g�ݍ��܂ꂽGem�p�b�P�[�W�̃o�[�W�����́AGemfile.lock���폜���āA�ēxbundle install�����s���邩bundle update���s��Ȃ�����A�o�[�W�����̈ˑ��֌W���ێ����Ă����B  

- package.json
node�̃p�b�P�[�W�Ǘ��c�[��npm���g�p����ꍇ�ɕK�v�ȃt�@�C���B

- Rakefile
Rake�^�X�N�R�}���h�̎��s���Ǘ����邽�߂̃t�@�C���B

- README.md
�N�����s�̎菇�Ɋւ��ċL�q����A�����p�̃t�@�C��


## app�f�B���N�g�����̃t�@�C����f�B���N�g���ɂ���

- controllers > concerns
�R���g���[���[���ʂ̃R�[�h���Ǘ����邽�߂̃f�B���N�g��

- helper
�w���p�[���W���[�����Ǘ����邽�߂̃f�B���N�g���B  
���ʂ̃w���p�[���\�b�h��񋟂��邽�߂�ApplicationHelper�����������B

- jobs
�W���u�N���X���Ǘ�����f�B���N�g��

- mailers
���[���[�N���X���Ǘ�����f�B���N�g��

- models
���f���N���X���Ǘ�����f�B���N�g��

## config�f�B���N�g�����̃t�@�C����f�B���N�g���ɂ���

- environments
���s���i�J���A�e�X�g�A�^�p�j���Ƃ̐ݒ�����Ǘ�����f�B���N�g��
�f�t�H���g��development���[�h

- initializers
���������̐ݒ�t�@�C�����Ǘ�����f�B���N�g��

- locales
�e������ʂ̕\�������Ǘ����鍑�ۉ��Ή������̖����̃��P�[�V�����t�@�C���i.yml�j���Ǘ�����f�B���N�g

- application.rb
�e���s���ɋ��ʂ���ݒ���s���t�@�C���B
�������Aenvironments�f�B���N�g�����D��B

- boot.rb
Gemfile�̏ꏊ���Ǘ����A�N������Gemfile�̈ꗗ����gem�̃Z�b�g�A�b�v���s���t�@�C��

- cable.yml
Action Cable�p�́A���ʂ̃f�t�H���g�L���[�A�_�v�^�[���Ǘ����邽�߂̃t�@�C��

- credentials.yml.enc
�Í����L�[�Ȃǂ��Ǘ����邽�߂̃t�@�C��

- database.yml
�f�[�^�x�[�X�̊��ݒ���s�����߂̃t�@�C��

- environment.rb
Rails s�ŁAapplication.rb�̏��������s���t�@�C��

- master.key
credentials.yml.enc�̏��𕜌����邽�߂̃L�[���ۑ�����Ă���t�@�C��

- puma.rb
Puma�̎��s����ݒ肷�邽�߂̃t�@�C��

- routes.rb
���[�^�[�̒�`�t�@�C��

- spring.rb
Spring�̐���̐ݒ���s���t�@�C��
  - Spring�Ƃ́A Rails�A�v���P�[�V��������N�����ɕK�v�ȃ��C�u���������[�h���������S���A�����I�ȊJ�����s����悤�ɂ��邽�߂̃v���O�����B

- storage.yml
Active Storage�̊��ݒ���s�����߂̃t�@�C��

## ���K��� 4.2

### 1 ���ɂ�����ARails�̂��ꂼ��̃f�B���N�g���i�t�H���_�[�j�̖������ȒP�ɐ������Ă��������B
- app  
  - ��  
  �A�v���P�[�V�����Ɋւ����񂪓������f�B���N�g���B���f���A�R���g���[���[�A�r���[�t�@�C���͑S�Ă��̒��ɂ���B

  - ����  
  �A�v���P�[�V�����Ɋւ�������Ǘ�����f�B���N�g���B

- assets  
  - ��  
  �r���[�Ɋւ��郊�\�[�X���܂Ƃ܂��Ă���f�B���N�g��

  - ����  
  Rails�A�Z�b�g�t�@�C�����Ǘ�����f�B���N�g���B���ꂪ�����A�A�Z�b�g�Ƃ̓r���[�ɑg�ݍ���HTML�ȊO��CSS��JavaScript�A�摜�Ȃǂ̗v�f�̂��ƁB

- controllers  
  - ��  
  ���f���ƃr���[�ɖ��߂𑗂�A�A�N�V�����𐧌䂷��ꏊ

  - ����  
  �R���g���[���[�N���X���Ǘ�����f�B���N�g���B

- models  
  - ��  
  �f�[�^�x�[�X�i���\�[�X�j�Ƃ̂���������t�@�C�����܂Ƃ܂��Ă���f�B���N�g�B

  - ����  
  ���f���N���X���Ǘ�����f�B���N�g���B

- views  
  - ��  
  ���N�G�X�g�ɑ΂��Ahtml�𐶐�����r���[�t�@�C�����z�u����Ă���f�B���N�g���B

  - ����  
  �r���[�e���v���[�g���Ǘ�����f�B���N�g���B

- config  
  - ��  
  �A�v���P�[�V�����̐ݒ���ɂ��ėl�X�ȃf�B���N�g����t�@�C�����i�[����Ă���f�B���N�g���B

  - ����  
  ���s���Ɋւ���ݒ��񂪓������f�B���N�g���B

- db  
  - ��  
  �f�[�^�x�[�X�Ɋւ����񂪊i�[����Ă���f�B���N�g���B�X�L�[�}��}�C�O���[�V�����t�@�C�����z�u����Ă���B

  - ����  
  ����

- environments  
  - ��  
  �킩��܂���B

  - ����  
  ���s�����Ƃ̐ݒ�����Ǘ�����f�B���N�g���B  
  ���s���Ƃ́A�J����development�F�e�X�g��test�F�^�p��production��3��  
  �f�t�H���g�͊J��

### 2 controllers,models�z����concerns�̖����ɂ��Đ������Ă��������B
- ��  
���ꂼ��icontrollers��models�j�ɂ����ċ��ʂ��鏈�����L�q����B

- ����  
���ʂ̃R�[�h���Ǘ����邽�߂̃f�B���N�g���B

### 3 ���[�g��ݒ肷��t�@�C���Ƃ��̊Ǘ��ꏊ�ɂ��Đ������Ă��������B

- ��  
���[�g��ݒ肷��t�@�C���́uroutes.rb�v�Ƃ����t�@�C���ŁAconfig�f�B���N�g���̒����ɐ�������Ă��܂��B

- ����  
����

### 4 ���ݒ��3�̃��[�h�Ƃ͂Ȃɂ��������Ă��������B

- ��  
�J�� = development
�e�X�g = test
�^�p = production

- ����  
����

### 5 config/application.rb��environments�f�B���N�g���Ƃ̊֌W�ɂ��Đ������Ă��������B

- ��  
config/application.rb�̓A�v���P�[�V�����ɂ����鋤�ʂ̐ݒ�����Ǘ�����t�@�C���ł���̂ɑ΂��Aenvironments�f�B���N�g���͎��s�����Ƃɐݒ�����Ǘ�����f�B���N�g���B

- ����  
config/application.rb�͊j���s���ɋ��ʂ̐ݒ���s���t�@�C���Benvironments�f�B���N�g�����̌ʐݒ肪�D�悳���B
environments�f�B���N�g���͎��s�����Ƃ̐ݒ�����Ǘ�����f�B���N�g���B
���Ȃ݂ɖ��O���قړ�����config/environment.rb�t�@�C����Rails�T�[�o�[�̋N�����ɁAapplication.rb�̏��������s���t�@�C���B


### 6 credentials.yml.enc�̖�����master.key�̊֌W��������Ă��������B

- ��  
credentials.yml.enc��
master.key��credentials.yml.enc�t�@�C���̈Í��𕜌����邽�߂̃L�[��ۊǂ��Ă���t�@�C���B

- ����  
credentials.yml.enc�͈Í����L�[�isecret_key_base�Ȃǁj���Ǘ����邽�߂̃t�@�C���B
master.key��credentials.yml.enc�̏��𕜌����邽�߂̃L�[���ۑ�����Ă���t�@�C���B

### 7 Gemfile��Gemfile.lock�̊֌W��������Ă��������B

- ��  
Gemfile�́Agem���Ǘ�����t�@�C���ŁAGemfile.lock�͎��ۂɃC���X�g�[������Ă���t�@�C�����L�q����Ă���t�@�C���ł��B  
gem��ǉ�����ꍇ�́Agemfile�ɋL�q���Agemfile.lock���폜������ŁAbundle install���邩�Abundle update���Ȃ��Ɛݒ肪���f����Ȃ��B  
�A�v���P�[�V������gemfile.lock�Ɛ��������ێ������ݒ���s���B  

- ��  
Gemfile��Rails�Ŏg�p����Gem�p�b�P�[�W�̐ݒ�t�@�C���B
Gemfile.lock��bundle install���ꂽGem�p�b�P�[�W�̈ˑ��֌W���Ǘ����邽�߂̃t�@�C���B
�قڂقڐ����B

### 8 ���̃t�@�C���̐����ꏊ�ɂ��āA�ȒP�ɐ������Ă��������B
- schema.rb  
- database.yml

- ��  
�A�v���P�[�V�����f�B���N�g��������db�f�B���N�g��

- ����  
schema.rb�Ɋւ��Ă͉𓚂Ő����B  
database.yml��config�f�B���N�g�̒����ɔz�u�����e���s���ɂ��āA�f�[�^�x�[�X�̊��ݒ���s�����߂̃t�@�C���B  

### 9 ���C�A�E�g�Ƒ��̃r���[�̊֌W��������Ă��������B

- ��  
�悭�킩��Ȃ��B

- ����  
layouts�͋��ʂ̃��C�A�E�g���Ǘ�����f�B���N�g���B  
�r���[�e���v���[�g�p��application.html.erb������ɒl����B  
���̃r���[�͊e�R���g���[���[���̃f�B���N�g���őΉ�����r���[�e���v���[�g���Ǘ�����Ă���B  


### 10 HTML�ȊO�̉�ʍ\���v�f�ƁA���̊Ǘ����@��������Ă��������B

- ��  
app/assets�f�B���N�g������css,javascript,�摜�t�@�C���Ȃǂ��Ǘ�����Ă���B

- ����  
����

# 4.3 rails�R�}���h

### Rails new
Rails �A�v���P�[�V�����̐���
```bash
$ rails new �A�v���P�[�V������[�I�v�V����]
```

Active Record�̐������X�L�b�v
```bash
$ rails new application -O
# ��������
$ rails new application --skip-active-record
```

�g�p�f�[�^�x�[�X���w�肷�鎞
```bash
$ rails new application -database=mysql
```
�f�t�H���g�ł�SQLite3���g�p�����B  
  
d�I�v�V�����Ŏg�p�ł���f�[�^�x�[�X�̎�ނ��m�F��������
```
$ rails new -h
```
���s����
```bash
-d, [--database=DATABASE]  
# Preconfigure for selected database (options: mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc)
```

�e�X�g�֘A�c�[���̃t���[���Z�b�g�𐶐��������Ȃ���
```bash
$ rails new application -T
# ��������
$ rails new application --skip-test-uni
```

bundle install�����������Ȃ���
```bash
$ rails new application -B
# ��������
$ rails new application --skip-bundle
```

concerns��images�Ȃǂ̋�f�B���N�g���𐶐��������Ȃ��Ƃ�
```bash
$ rails new application --skip-keeps
```

API����邽�߂̃I�v�V����  
�r���[�Ɋ֘A�����@�\�̐������s��Ȃ��A�y�ʂȃt���[�����[�N���쐬����B
```bash
$ rails new application --api
```

### rails g(Rails�A�v���P�[�V�����v�f�̐���)

��{
```bash
$ rails g �W�F�l���[�^�[��� ���� [�I�v�V����]
```

�R���g���[���[�𐶐�����  
�R���g���[���[���͏����������`(��Fbooks)�����[��
```bash
$ rails g controller �R���g���[���[��
```

�A�N�V���������w�肵�A�Ή����郋�[�g�����[�^�[�ɒǉ����Aview�̃X�P���g���𐶐����ė~�����Ƃ�
```bash
$ rails g controller �R���g���[���[�� �A�N�V������
```

���f���̐����ƃ}�C�O���[�V�����t�@�C����db/migrate�f�B���N�g���ɐ������鎞�Ɏg�p  
���f�����͑啶������n�܂�P���`�����[��
```bash
$ rails g models ���f���� ������:�^�C�v
# Book���f����string�^�C�v�Ń^�C�g��(title)��text�^�C�v�Ŋ��z(thoughts)��ۑ����������ꍇ
$ rails g models Book title:string thoughts:text
```




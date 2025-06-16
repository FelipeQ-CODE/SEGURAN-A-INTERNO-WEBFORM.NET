<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastroUsuario.aspx.cs"
    Inherits="SEGURANÇA_INTERNO_WEBFORM.NET.cadastro.cadastroUsuario"
    MasterPageFile="~/master_page.master" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <title>Cadastro de Usuários</title>
    <link rel="stylesheet" href="/style/style.css" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Conteúdo da página -->
    <div class="container">
        <div class="header">
            <h1>Cadastro de Usuário</h1>
            <p>Preencha os dados abaixo para criar sua conta</p>
        </div>

        <div class="success-message" id="successMessage">
            Usuário cadastrado com sucesso!
        </div>

        <form id="userRegistrationForm">
            <div class="form-group">
                <label for="userName">Nome Completo *</label>
                <input type="text" id="userName" name="name" required>
                <div class="error-message" id="nameError"></div>
            </div>

            <div class="form-group">
                <label for="userBirthDate">Data de Nascimento *</label>
                <input type="date" id="userBirthDate" name="birthDate" required>
                <div class="error-message" id="birthDateError"></div>
            </div>

            <div class="form-group">
                <label for="userEmail">Email *</label>
                <input type="email" id="userEmail" name="email" required>
                <div class="error-message" id="emailError"></div>
            </div>

            <div class="form-group">
                <label for="userPassword">Senha *</label>
                <input type="password" id="userPassword" name="password" required>
                <div class="error-message" id="passwordError"></div>
            </div>

            <div class="form-group">
                <label for="userPhoto">Foto do Perfil</label>
                <div class="photo-upload" onclick="document.getElementById('userPhoto').click()">
                    <input type="file" id="userPhoto" name="photo" accept="image/*">
                    <img class="photo-preview" id="photoPreview" alt="Preview da foto">
                    <div class="upload-icon" id="uploadIcon">📷</div>
                    <div class="upload-text" id="uploadText">
                        <strong>Clique para selecionar uma foto</strong><br>
                        <small>PNG, JPG até 5MB</small>
                    </div>
                </div>
                <div class="error-message" id="photoError"></div>
            </div>

            <button type="submit" class="btn-submit" id="submitBtn">
                Cadastrar Usuário
            </button>

            <div class="loading" id="loading">
                <div class="spinner"></div>
                <p>Processando cadastro...</p>
            </div>
        </form>
    </div>

    <!-- Script JS -->
    <script src="script.js"></script>

    <!-- Ou o código JS inline -->
    <script>
        // Elementos do DOM
        const form = document.getElementById("userRegistrationForm")
        const photoInput = document.getElementById("userPhoto")
        const photoPreview = document.getElementById("photoPreview")
        const uploadIcon = document.getElementById("uploadIcon")
        const uploadText = document.getElementById("uploadText")
        const submitBtn = document.getElementById("submitBtn")
        const loading = document.getElementById("loading")
        const successMessage = document.getElementById("successMessage")

        // Validação em tempo real
        const inputs = {
            userName: document.getElementById("userName"),
            userBirthDate: document.getElementById("userBirthDate"),
            userEmail: document.getElementById("userEmail"),
            userPassword: document.getElementById("userPassword"),
        }

        const errors = {
            nameError: document.getElementById("nameError"),
            birthDateError: document.getElementById("birthDateError"),
            emailError: document.getElementById("emailError"),
            passwordError: document.getElementById("passwordError"),
            photoError: document.getElementById("photoError"),
        }

        // Funções de validação
        function validateName(name) {
            if (name.length < 2) {
                return "Nome deve ter pelo menos 2 caracteres"
            }
            if (!/^[a-zA-ZÀ-ÿ\s]+$/.test(name)) {
                return "Nome deve conter apenas letras e espaços"
            }
            return ""
        }

        function validateBirthDate(date) {
            if (!date) return "Data de nascimento é obrigatória"

            const birthDate = new Date(date)
            const today = new Date()
            const age = today.getFullYear() - birthDate.getFullYear()

            if (age < 13) {
                return "Idade mínima é 13 anos"
            }
            if (age > 120) {
                return "Data de nascimento inválida"
            }
            return ""
        }

        function validateEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
            if (!emailRegex.test(email)) {
                return "Email inválido"
            }
            return ""
        }

        function validatePassword(password) {
            if (password.length < 6) {
                return "Senha deve ter pelo menos 6 caracteres"
            }
            if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(password)) {
                return "Senha deve conter ao menos: 1 letra minúscula, 1 maiúscula e 1 número"
            }
            return ""
        }

        function validatePhoto(file) {
            if (!file) return ""

            const maxSize = 5 * 1024 * 1024 // 5MB
            const allowedTypes = ["image/jpeg", "image/png", "image/gif"]

            if (file.size > maxSize) {
                return "Arquivo deve ter no máximo 5MB"
            }
            if (!allowedTypes.includes(file.type)) {
                return "Apenas arquivos PNG, JPG e GIF são permitidos"
            }
            return ""
        }

        // Event listeners para validação em tempo real
        inputs.userName.addEventListener("blur", function () {
            const error = validateName(this.value)
            showError("nameError", error)
        })

        inputs.userBirthDate.addEventListener("change", function () {
            const error = validateBirthDate(this.value)
            showError("birthDateError", error)
        })

        inputs.userEmail.addEventListener("blur", function () {
            const error = validateEmail(this.value)
            showError("emailError", error)
        })

        inputs.userPassword.addEventListener("input", function () {
            const error = validatePassword(this.value)
            showError("passwordError", error)
        })

        function showError(errorId, message) {
            const errorElement = errors[errorId]
            if (message) {
                errorElement.textContent = message
                errorElement.style.display = "block"
            } else {
                errorElement.style.display = "none"
            }
        }

        // Preview da foto
        photoInput.addEventListener("change", (e) => {
            const file = e.target.files[0]
            const error = validatePhoto(file)
            showError("photoError", error)

            if (file && !error) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    photoPreview.src = e.target.result
                    photoPreview.style.display = "block"
                    uploadIcon.style.display = "none"
                    uploadText.innerHTML = "<strong>Foto selecionada</strong><br><small>Clique para alterar</small>"
                }
                reader.readAsDataURL(file)
            } else if (!file) {
                resetPhotoUpload()
            }
        })

        function resetPhotoUpload() {
            photoPreview.style.display = "none"
            uploadIcon.style.display = "block"
            uploadText.innerHTML = "<strong>Clique para selecionar uma foto</strong><br><small>PNG, JPG até 5MB</small>"
        }

        // Submissão do formulário
        form.addEventListener("submit", (e) => {
            e.preventDefault()

            // Validar todos os campos
            const nameError = validateName(inputs.userName.value)
            const birthDateError = validateBirthDate(inputs.userBirthDate.value)
            const emailError = validateEmail(inputs.userEmail.value)
            const passwordError = validatePassword(inputs.userPassword.value)
            const photoError = validatePhoto(photoInput.files[0])

            // Mostrar erros
            showError("nameError", nameError)
            showError("birthDateError", birthDateError)
            showError("emailError", emailError)
            showError("passwordError", passwordError)
            showError("photoError", photoError)

            // Se houver erros, não submeter
            if (nameError || birthDateError || emailError || passwordError || photoError) {
                return
            }

            // Simular envio para o backend
            submitForm()
        })

        async function submitForm() {
            // Mostrar loading
            submitBtn.style.display = "none"
            loading.style.display = "block"

            // Preparar dados para envio
            const formData = new FormData()
            formData.append("name", inputs.userName.value)
            formData.append("birthDate", inputs.userBirthDate.value)
            formData.append("email", inputs.userEmail.value)
            formData.append("password", inputs.userPassword.value)

            if (photoInput.files[0]) {
                formData.append("photo", photoInput.files[0])
            }

            try {
                // Simular chamada para API (substitua pela sua URL de backend)
                // const response = await fetch('/api/users/register', {
                //     method: 'POST',
                //     body: formData
                // });

                // Simulação de delay da API
                await new Promise((resolve) => setTimeout(resolve, 2000))

                // Simular sucesso
                console.log("Dados que seriam enviados para o backend:")
                console.log("Nome:", inputs.userName.value)
                console.log("Data de Nascimento:", inputs.userBirthDate.value)
                console.log("Email:", inputs.userEmail.value)
                console.log("Senha:", inputs.userPassword.value)
                console.log("Foto:", photoInput.files[0] ? photoInput.files[0].name : "Nenhuma foto")

                // Mostrar mensagem de sucesso
                successMessage.style.display = "block"
                form.reset()
                resetPhotoUpload()

                // Scroll para o topo
                window.scrollTo({ top: 0, behavior: "smooth" })
            } catch (error) {
                console.error("Erro ao cadastrar usuário:", error)
                alert("Erro ao cadastrar usuário. Tente novamente.")
            } finally {
                // Esconder loading
                loading.style.display = "none"
                submitBtn.style.display = "block"
            }
        }

        // Função para integração com backend (exemplo)
        function getUserData() {
            return {
                id: null, // Será gerado pelo backend
                name: document.getElementById("userName").value,
                birthDate: document.getElementById("userBirthDate").value,
                email: document.getElementById("userEmail").value,
                password: document.getElementById("userPassword").value,
                photo: document.getElementById("userPhoto").files[0] || null,
            }
        }

        // Limpar mensagem de sucesso ao começar a digitar novamente
        Object.values(inputs).forEach((input) => {
            input.addEventListener("input", () => {
                successMessage.style.display = "none"
            })
        })

</script>
</asp:Content>

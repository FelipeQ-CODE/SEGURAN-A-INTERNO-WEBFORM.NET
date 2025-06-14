<%@ Page Title="Início" Language="C#" MasterPageFile="~/master_page.master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SEGURANÇA_INTERNO_WEBFORM.NET.INDEX.Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="content">
        <section class="hero">
            <div class="container">
                <h1>Sistema de Segurança Interna</h1>
                <p>Plataforma integrada para gerenciamento de segurança e controle de acessos</p>
                <button class="btn-primary">Saiba Mais</button>
            </div>
        </section>

        <section class="features">
            <div class="container">
                <h2>Recursos Principais</h2>
                <div class="feature-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🔒</div>
                        <h3>Controle de Acesso</h3>
                        <p>Gerencie permissões e níveis de acesso para todos os usuários do sistema.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">👤</div>
                        <h3>Gestão de Usuários</h3>
                        <p>Cadastre, edite e monitore todos os usuários da plataforma.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">📊</div>
                        <h3>Relatórios</h3>
                        <p>Visualize estatísticas e relatórios detalhados sobre acessos e atividades.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">🔔</div>
                        <h3>Notificações</h3>
                        <p>Receba alertas sobre eventos importantes de segurança.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="cta">
            <div class="container">
                <h2>Comece a utilizar agora</h2>
                <p>Entre em contato com o suporte para solicitar acesso ao sistema</p>
                <button class="btn-secondary">Contatar Suporte</button>
            </div>
        </section>
    </main>

</asp:Content>
